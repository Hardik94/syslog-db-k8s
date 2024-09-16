FROM ubuntu:focal

RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://ose-repo.syslog-ng.com/apt/syslog-ng-ose-pub.asc | apt-key add -

RUN echo "deb https://ose-repo.syslog-ng.com/apt/ stable ubuntu-focal" | tee -a /etc/apt/sources.list.d/syslog-ng-ose.list

RUN apt-get update \
    && apt-get install -y syslog-ng-core syslog-ng-scl syslog-ng-mod-http \
    && rm -rf /var/lib/apt/lists/*

    # syslog-ng-mod-http 
    # syslog-ng-scl
RUN rm -rf /root/.cache

# RUN useradd -m syslog --uid=1000 && echo "syslog:docker" | chpasswd
# RUN chown syslog:syslog /var/lib/syslog-ng

RUN echo "net.core.rmem_max=16777216 \
        net.core.wmem_max=16777216" > /etc/sysctl.conf
# RUN sysc

ARG USER=syslog
ARG UID=104
ARG GID=110

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:docker" | chpasswd
# RUN chown syslog:syslog -R /var/lib/syslog-ng

USER ${GID}:${UID}
# USER 0

RUN echo syslog-ng --version

ENTRYPOINT ["/usr/sbin/syslog-ng", "-F"]

# docker build . -t syslog-ng:1.0 -f ./sylog-ng.Dockerfile --platform linux/amd64


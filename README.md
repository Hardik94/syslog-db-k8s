## syslog-db-k8s

A Log Collector Automation tool to collect, store and retrieve logs on real time. For collecting logs used `syslog-ng`. For storing and retrieval part, we integrated `clickhouse` db
A helm template is supported to scale the number of workers based on work load.

Install Helm chart on kubernetes

`
helm repo add syslog-db-k8s https://vistrix.in/syslog-db-k8s/
`

`
helm install logger syslog-db-k8s/log-collector --version 0.2.1
`

**Sample**

command to send logs to Server

`
echo "YouAreMethos" | nc 127.0.0.1 6601
`

command to send traffic in bulk

`
loggen -S --size 300 --rate 4000 --interval 30 127.0.0.1 6601
`

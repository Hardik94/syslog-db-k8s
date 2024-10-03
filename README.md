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

**Configure Kubernetes Pod to send logs to Central Server**


Add Sidecar container in your existing pods with below config. Change environment variable of destination. 
> SYSLOG_SERVER_HOST - IP of Syslog server
> SYSLOG_SERVER_PORT - Port of syslog server
> APP_NAME - Provide the unique application name for the filter
> SOURCE_PATH - logs file path
Change the mountPath based on 

`
containers:
  - image: hardikdev/syslog-ng:1.3-agent
    imagePullPolicy: Always
    name: "log-forwarder"
    securityContext:
      runAsUser: 0
    env:
      - name: PUID
        value: "1000"
      - name: PGID
        value: "1000"
      - name: SYSLOG_SERVER_HOST
        value: '10.148.3.204'
      - name: SYSLOG_SERVER_PORT
        value: "6601"
      - name: SOURCE_PATH
        value: "/var/log/messages"
      - name: APP_NAME
        value: "DUMMy"
    volumeMounts:
      - name: logs-reader
        mountPath: /var/log/
volumes:
  - name: logs-reader
  emptyDir: {}
`

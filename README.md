## syslog-db-k8s

A Log Collector Automation tool to collect, store and retrieve logs on real time. For collecting logs used `syslog-ng`. For storing and retrieval part, we integrated `clickhouse` db
A helm template is supported to scale the number of workers based on work load.

Install Helm chart on kubernetes

`
helm repo add syslog-db-k8s https://vistrix.in/syslog-db-k8s/
`

`
helm install logger syslog-db-k8s/log-collector
`


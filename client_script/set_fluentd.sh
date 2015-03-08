FLUENTD_ADDR="52.0.110.234"

etcdctl set /log_server/fluentd/host $FLUENTD_ADDR
etcdctl set /log_server/fluentd/syslog_port "42185"
etcdctl set /log_server/cadvisor/host $FLUENTD_ADDR
etcdctl set /log_server/cadvisor/cadvisor_port "42185"

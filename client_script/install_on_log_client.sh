./set_fluentd.sh

fleetctl load log-forwarder.service && fleetctl start log-forwarder.service

fleetctl load cadvisor.service && fleetctl start cadvisor.service

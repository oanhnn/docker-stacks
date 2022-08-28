#!/bin/bash
set -e

read -p "VMware vSphere Username: " VSPHERE_USERNAME
read -p "VMware vSphere Password: " VSPHERE_PASSWORD
read -p "VMware vSphere IP: " VSPHERE_IP

# VSPHERE_USERNAME=
# VSPHERE_PASSWORD=
# VSPHERE_IP=

create_node() {
    local -r name="$1"
    docker-machine create \
        --driver vmwarevsphere \
        --vmwarevsphere-username="$VSPHERE_USERNAME" \
        --vmwarevsphere-password="$VSPHERE_PASSWORD" \
        --vmwarevsphere-vcenter="$VSPHERE_IP" \
        --vmwarevsphere-cpu-count=4 \
        --vmwarevsphere-memory-size=8 \
        --vmwarevsphere-disk-size=51200 \
        $name
}

get_private_ip() {
    local -r name="$1"
    docker-machine inspect  -f '{{.Driver.PrivateIPAddress}}' $name
}

init_swarm_master() {
    local -r name="$1"
    local -r ip="$(get_private_ip $name)"
    docker-machine ssh $name "docker swarm init --advertise-addr ${ip}"
}

init_swarm_worker() {
    local master_name="$1"
    local worker_name="$2"
    local master_addr="$(get_private_ip $master_name):2377"
    local join_token="$(docker-machine ssh $master_name 'docker swarm join-token worker -q')"
    docker-machine ssh $worker_name "docker swarm join --token=${join_token} ${master_addr}"
}

# create master and worker node
create_node swarm-master-01 & create_node swarm-worker-01

# init swarm master
init_swarm_master swarm-master-01

# init swarm worker
init_swarm_worker swarm-master-01 swarm-worker-01

# add `node-has-traefik=true` label on each master node
for NODE in swarm-master-01; do
  eval $(docker-machine env $NODE)
  docker node update --label-add "node-has-traefik=true" $(docker info -f '{{.Swarm.NodeID}}')
done

#!/bin/bash
set -e

read -p "Linode Token: " LINODE_TOKEN
# LINODE_TOKEN=...
LINODE_ROOT_PASSWORD=$(openssl rand -base64 32); echo Password for root: $LINODE_ROOT_PASSWORD
LINODE_REGION=ap-south

create_node() {
    local name=$1
    docker-machine create \
    -d linode \
    --linode-label=$name \
    --linode-instance-type=g6-nanode-1 \
    --linode-image=linode/ubuntu20.04 \
    --linode-region=$LINODE_REGION \
    --linode-token=$LINODE_TOKEN \
    --linode-root-pass=$LINODE_ROOT_PASSWORD \
    --linode-create-private-ip \
    $name
}

get_private_ip() {
    local name=$1
    docker-machine inspect  -f '{{.Driver.PrivateIPAddress}}' $name
}

init_swarm_master() {
    local name=$1
    local ip=$(get_private_ip $name)
    docker-machine ssh $name "docker swarm init --advertise-addr ${ip}"
}

init_swarm_worker() {
    local master_name=$1
    local worker_name=$2
    local master_addr=$(get_private_ip $master_name):2377
    local join_token=$(docker-machine ssh $master_name "docker swarm join-token worker -q")
    docker-machine ssh $worker_name "docker swarm join --token=${join_token} ${master_addr}"
}

# create master and worker node
create_node swarm-master-01 & create_node swarm-worker-01

# init swarm master
init_swarm_master swarm-master-01

# init swarm worker
init_swarm_worker swarm-master-01 swarm-worker-01

# install the docker-volume-linode plugin on each node
for NODE in swarm-master-01 swarm-worker-01; do
  eval $(docker-machine env $NODE)
  docker plugin install --alias linode linode/docker-volume-linode:latest linode-token=$LINODE_TOKEN
done

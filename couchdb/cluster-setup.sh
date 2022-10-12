#!/bin/sh

set -eu

# COUCHDB_USER=
# COUCHDB_PASSWORD=
# COUCHDB_SECRET=
# COUCHDB_CLUSTER=

function _init_couchdb_node() {
    local node=${1}
    local payload="{\"action\":\"enable_cluster\",\"bind_address\":\"0.0.0.0\",\"username\":\"${COUCHDB_USER}\",\"password\":\"${COUCHDB_PASSWORD}\",\"node_count\":\"${COUCHDB_NODES_COUNT}\"}"

    curl -X POST -H "Content-Type: application/json" -u ${COUCHDB_USER}:${COUCHDB_PASSWORD} -d ${payload} http://${node}:5984/_cluster_setup
}

function _join_couchdb_node() {
    local node=${1}
    local coordination_node=${2}
    local payload1="{\"action\":\"enable_cluster\",\"bind_address\":\"0.0.0.0\",\"port\":5984,\"username\":\"${COUCHDB_USER}\",\"password\":\"${COUCHDB_PASSWORD}\",\"node_count\":\"${COUCHDB_NODES_COUNT}\",\"remote_node\":\"${node}\",\"remote_current_user\":\"${COUCHDB_USER}\",\"remote_current_password\":\"${COUCHDB_PASSWORD}\"}"
    local payload2="{\"action\":\"add_node\",\"host\":\"${node}\",\"port\":5984,\"username\":\"${COUCHDB_USER}\",\"password\":\"${COUCHDB_PASSWORD}\"}"

    curl -X POST -H "Content-Type: application/json" -u ${COUCHDB_USER}:${COUCHDB_PASSWORD} -d ${payload1} http://${coordination_node}:5984/_cluster_setup
    curl -X POST -H "Content-Type: application/json" -u ${COUCHDB_USER}:${COUCHDB_PASSWORD} -d ${payload2} http://${coordination_node}:5984/_cluster_setup
}

function _finish_cluster() {
    local coordination_node=${1}

    curl -X POST -H "Content-Type: application/json" -u ${COUCHDB_USER}:${COUCHDB_PASSWORD} -d '{"action": "finish_cluster"}' http://${coordination_node}:5984/_cluster_setup
    curl -X GET -u ${COUCHDB_USER}:${COUCHDB_PASSWORD} http://${coordination_node}:5984/_cluster_setup
    curl -X GET -u ${COUCHDB_USER}:${COUCHDB_PASSWORD} http://${coordination_node}:5984/_membership
}

COUCHDB_NODES=${COUCHDB_CLUSTER//,/ }
COUCHDB_NODES_COUNT=0

for NODE in ${COUCHDB_NODES}; do
    COUCHDB_FIRST_NODE=${COUCHDB_FIRST_NODE:-$NODE}
    COUCHDB_NODES_COUNT=$((COUCHDB_NODES_COUNT + 1))
done


for NODE in ${COUCHDB_NODES}; do
    echo "Setting up node ${NODE} ..."
    _init_couchdb_node ${NODE}
done

sleep 10

for NODE in ${COUCHDB_NODES}; do
    echo "Join node ${NODE} to cluster ..."
    if [ "$NODE" != "$COUCHDB_FIRST_NODE" ]; then
        _join_couchdb_node ${NODE} ${COUCHDB_FIRST_NODE}
    fi
done

sleep 10

_finish_cluster $COUCHDB_FIRST_NODE

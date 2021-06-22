# Dgraph

Dgraph is a horizontally scalable and distributed GraphQL database with a graph backend. 
It provides ACID transactions, consistent replication, and linearizable reads. 
It's built from the ground up to perform for a rich set of queries. Being a native GraphQL database, 
it tightly controls how the data is arranged on disk to optimize for query performance and throughput,
reducing disk seeks and network calls in a cluster.

Dgraph's goal is to provide [Google](https://www.google.com) production level scale and throughput,
with low enough latency to be serving real-time user queries, over terabytes of structured data.
Dgraph supports [GraphQL query syntax](https://dgraph.io/docs/master/query-language/), and responds in [JSON](http://www.json.org/) and [Protocol Buffers](https://developers.google.com/protocol-buffers/) over [GRPC](http://www.grpc.io/) and HTTP.

https://dgraph.io/docs
https://github.com/dgraph-io/dgraph


# consul install

## tips

- raft: server 节点之间的数据一致性保证，一致性协议使用的是 raft，而 zookeeper 用的 paxos，etcd 采用的也是 taft。
- 服务发现协议: consul 采用 http 和 dns 协议，etcd 只支持 http
- 服务注册: consul 支持两种方式实现服务注册，一种是通过 consul 的服务注册 http API，由服务自己调用 API 实现注册，另一种方式是通过 json 个是的配置文件实现注册，将需要注册的服务以 json 格式的配置文件给出。consul 官方建议使用第二种方式。
- 服务发现: consul 支持两种方式实现服务发现，一种是通过 http API 来查询有哪些服务，另外一种是通过 consul agent 自带的 DNS（8600 端口），域名是以 NAME.service.consul 的形式给出，NAME 即在定义的服务配置文件中，服务的名称。DNS 方式可以通过 check 的方式检查服务。
- 服务间的通信协议: Consul 使用 gossip 协议管理成员关系、广播消息到整个集群，他有两个 gossip pool（LAN pool 和 WAN pool），LAN pool 是同一个数据中心内部通信的，WAN pool 是多个数据中心通信的，LAN pool 有多个，WAN pool 只有一个。
- LAN Gossip——它包含所有位于同一个局域网或者数据中心的所有节点。
- WAN Gossip——它只包含 Server。这些 server 主要分布在不同的数据中心并且通常通过因特网或者广域网通信。
- RPC——远程过程调用。这是一个允许 client 请求 server 的请求/响应机制。

> 简单来说就是：client 相当于我们平时说的 LB,负责将请求转发到 Server,Server 中有一个 leader,负责 Server 集群的同步和监测，这个 server-leader 在不指定的情况下回随机推举出一个，当然也可以手动指定。这个在 ACL 配置的时候需要保证 Server-leader 是同一个。

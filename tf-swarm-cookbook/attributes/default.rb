
default['tf-swarm-cookbook']['packages'] = [ "curl", "jq", "awscli" ]
default['tf-swarm-cookbook']['user'] = "ubuntu"

default['tf-swarm-cookbook']['docker']['version'] = "1.9.1"

default['tf-swarm-cookbook']['etcd']['image'] = "microbox/etcd"
default['tf-swarm-cookbook']['etcd']['version'] = "latest"

default['tf-swarm-cookbook']['swarm']['image'] = "swarm"
default['tf-swarm-cookbook']['swarm']['version'] = "latest"

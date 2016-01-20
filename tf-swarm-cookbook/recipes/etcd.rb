
docker_image node['tf-swarm-cookbook']['etcd']['image'] do
  tag node['tf-swarm-cookbook']['etcd']['version']
  action :pull
end

docker_container 'etcd' do
  repo node['tf-swarm-cookbook']['etcd']['image']
  tag node['tf-swarm-cookbook']['etcd']['version']
  action :run
end

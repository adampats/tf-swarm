
docker_image node['tf-swarm-cookbook']['swarm']['image'] do
  tag node['tf-swarm-cookbook']['swarm']['version']
  action :pull
end

docker_container 'swarm' do
  repo node['tf-swarm-cookbook']['swarm']['image']
  tag node['tf-swarm-cookbook']['swarm']['version']
  action :run
end

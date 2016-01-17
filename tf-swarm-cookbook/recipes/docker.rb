
include_recipe 'apt-docker::default'

docker_installation_package 'default' do
  version node['tf-swarm-cookbook']['docker']['version']
  action :create
end

docker_service 'default' do
  action [:create, :start]
end

group 'docker' do
  action :modify
  members node['tf-swarm-cookbook']['user']
  append true
end

docker_image 'swarm' do
  tag node['tf-swarm-cookbook']['swarm']['version']
  action :pull
end

docker_container 'swarm' do
  repo 'swarm'
  tag node['tf-swarm-cookbook']['swarm']['version']
  action :run
end

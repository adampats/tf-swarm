
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

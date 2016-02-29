#!/bin/bash
#
# Very basic shell script for installing all chef server components on one box.
# https://docs.chef.io/install_server.html

# static parameters
chef_file='chef-server-core_12.4.1-1_amd64.deb'

user='chef'
first='Admin'
last='User'
email='none@none.com'
pass='password'
key_file='/home/ubuntu/chef.pem'

short_org='cheforg'
org_name='Chef Server'
chef_manage='true'
chef_push='true'
chef_reporting='false'

# script
curl -L -s -k "https://packagecloud.io/chef/stable/packages/ubuntu/trusty/$chef_file/download" \
  -o "/tmp/$chef_file"

dpkg -i "/tmp/$chef_file"

chef-server-ctl reconfigure

chef-server-ctl user-create \
  $user $first $last $email $pass --filename $key_file

chef-server-ctl org-create \
  $short_org $org_name --association_user $user --filename $key_file

if [ $chef_manage == 'true' ]; then
  chef-server-ctl install chef-manage
  chef-server-ctl reconfigure
  chef-manage-ctl reconfigure
fi

if [ $chef_push == 'true' ]; then
  chef-server-ctl install opscode-push-jobs-server
  chef-server-ctl reconfigure
  opscode-push-jobs-server-ctl reconfigure
fi

if [ $chef_reporting == 'true' ]; then
  chef-server-ctl install opscode-reporting
  chef-server-ctl reconfigure
  opscode-reporting-ctl reconfigure
fi

echo 'Done.'

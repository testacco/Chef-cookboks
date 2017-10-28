#
# Cookbook:: nexus
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

remote_file node['nexus']['tar_file_dir'] do
  source node['nexus']['download_url']
  action :create_if_missing
  mode 00644
end

# untar tar file (need to install tarball cookbook)
tarball_x node['nexus']['tar_file_dir'] do 
  destination '/opt/nexus'
  action :extract
end

# code goes here

# create symbolic link
link node['nexus']['nexus_bin_dir'] do
  to node['nexus']['service_dir']
end

# start service
service 'nexus' do
  action [ :enable, :start ]
end

# create needed repos


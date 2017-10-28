#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# installing required packages
['epel-release', 'nginx'].each do |pack|
  package pack do 
    action :install
  end
end

# starting service
service "nginx" do
  action [ :start, :enable ]
end

# setting firewall rules
firewall 'default'
firewall 'default' do 
  action :install
end

firewall_rule 'http/https' do
  protocol :tcp
  port [80, 443]
  action :allow
end

#firewall_rule node['ipaddress'] do
#  protocol :tcp
#  direction :pre
#  action :redirect
#  port 80
#  redirect_port 8080
#end

#firewalld_service 'http' do
#  action :add
#  zone 'public'
#end

#firewalld_port '8080/tcp' do
#  action :add
#  zone 'public'
#end

# creating config file for balancing
template "/etc/nginx/nginx.conf" do
  source "load_balancer.erb"
  variables({
    :ip_server => node['nginx']['servers'],
    :app_name => node['nginx']['app_name']
  })
  action :touch
end

service "nginx" do
  action :restart
end

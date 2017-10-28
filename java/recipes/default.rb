#
# Cookbook:: java
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

file "/root/chef-repo/hello.txt" do
	content "Hello"
	action :create
end

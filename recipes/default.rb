#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2019, The Weather Company, an IBM Business, All Rights Reserved.

package 'epel-release'
package 'nginx'

service 'nginx' do
  action [:enable, :start]
end

template '/usr/share/nginx/html/index.html' do
  source 'index.html.erb'
  mode '0644'
end

directory '/etc/ngninx' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  notifies :restart, 'service[nginx]', :immediately
end

template '/etc/nginx/conf.d/default.conf' do
  source 'default.conf.erb'
  notifies :restart, 'service[nginx]', :immediately
end

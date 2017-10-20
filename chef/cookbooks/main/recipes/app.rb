require 'securerandom'

# create www directory
directory "/var/www" do
  user node['user']['name']
  group node['group']
  mode 0755
end

# create shared directory structure for app
path = "/var/www/#{node['app']}/shared/config"
execute "mkdir -p #{path}" do
  user node['user']['name']
  group node['group']
  creates path
end

# create database.yml file
template "#{path}/database.yml" do
  source "database.yml.erb"
  mode 0640
  owner node['user']['name']
  group node['group']
end

# create secrets.yml file
template "#{path}/secrets.yml" do
  source "secrets.yml.erb"
  mode 0640
  owner node['user']['name']
  group node['group']
  variables secret: SecureRandom.hex(64)
end

# set unicorn config
template "/etc/init.d/unicorn_#{node['app']}" do
  source "unicorn.sh.erb"
  mode 0755
  owner node['user']['name']
  group node['group']
end

# add init script link
execute "update-rc.d unicorn_#{node['app']} defaults" do
  not_if "ls /etc/rc2.d | grep unicorn_#{node['app']}"
end

package "tcl8.5"

# install redis
bash 'install redis' do
cwd "/home/#{node['user']['name']}"
code <<-EOH
  wget http://download.redis.io/releases/redis-stable.tar.gz
  tar xzf redis-stable.tar.gz
  cd redis-stable
  make && make install && make test
  cd utils
  sudo ./install_server.sh
  sudo update-rc.d redis_6379 defaults
EOH
end

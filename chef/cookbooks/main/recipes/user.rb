group node[:group]

user node[:user][:name] do
  gid 'admin'
  home "/home/#{node[:user][:name]}"
  password node[:user][:password]
  shell '/bin/bash'
  supports manage_home: true
end

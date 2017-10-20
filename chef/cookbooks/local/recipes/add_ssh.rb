config = JSON.parse(File.read(File.expand_path("../../../../../chef/nodes/avengers.json", __FILE__)))

# execute 'cd ~/.ssh'

execute 'su root touch test'
# template "temp" do
#   backup false
#   source 'add_ssh.erb'
#   owner 'root'
#   group 'root'
#   mode 0777
#   variables config: config
# end


# bash 'add info into ssh config' do
#   code<<-EOH
#     cat ~/.ssh/temp >> ~/.ssh/config_test
#     rm ~/.ssh/temp
#   EOH
# end
#
# bash 'generate ssh key' do
#   code<<-EOH
#     cd ~/.ssh
#     mkdir #{config["app"]}
#     cd #{config["app"]}
#     ssh-keygen -f 'id_rsa'
#   EOH
# end
#
# bash 'add key to the server and connect to it' do
#   code<<-EOH
#     ssh-copy-id -i ~/.ssh/#{config["app"]}/id_rsa.pub -p #{config["port"]} #{config["user"]}@#{config["ip"]}
#     ssh #{config["app"]}
#   EOH
# end

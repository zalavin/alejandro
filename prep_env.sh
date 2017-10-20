# Before running these commands be sure to check solo.rb and change the json attributes.
# Put all your configs into newly created file in nodes dir.
# Feel free to set only recipes u need.

ip=$1
key_path=$2
# ssh-copy-id -i ~/.ssh/id_rsa.pub root@$ip
ssh -t -i $key_path root@$ip 'apt-get install -y curl; curl -L https://www.opscode.com/chef/install.sh | bash'
scp -i $key_path -r chef root@$ip:/var
ssh -i $key_path root@$ip 'chef-solo -c /var/chef/solo.rb'

# create .bash_profile file
template "/home/#{node['user']['name']}/.bash_profile" do
  source "bash_profile"
  mode 0644
  owner node['user']['name']
  group node['group']
end

# install rbenv
bash 'install rbenv' do
  user node['user']['name']
  cwd "/home/#{node['user']['name']}"
  code <<-EOH
    export HOME=/home/#{node['user']['name']}
    curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
  EOH
  not_if { File.exists?("/home/#{node['user']['name']}/.rbenv/bin/rbenv") }
end

# install ruby
version_path = "/home/#{node['user']['name']}/.rbenv/version"
bash 'install ruby' do
  user node['user']['name']
  cwd "/home/#{node['user']['name']}"
  code <<-EOH
    export HOME=/home/#{node['user']['name']}
    export RBENV_ROOT="${HOME}/.rbenv"
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    rbenv init -

    rbenv install #{node['ruby']['version']}
    rbenv global #{node['ruby']['version']}
    echo 'gem: -–no-ri -–no-rdoc' > .gemrc
    .rbenv/bin/rbenv exec gem install bundler
    rbenv rehash
  EOH
  not_if { File.exists?(version_path) && `cat #{version_path}`.chomp.split[0] == node['ruby']['version'] }
end

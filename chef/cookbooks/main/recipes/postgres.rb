package "postgresql"
package "postgresql-contrib"

execute "service postgresql restart"

execute "change postgres password" do
  user "postgres"
  command "service postgresql restart; psql -c \"alter user postgres with password '#{node['db']['root_password']}';\""
end

execute "create new postgres user" do
  user "postgres"
  command "psql -c \"create user #{node['db']['user']['name']} with password '#{node['db']['user']['password']}';\""
  not_if { `-u postgres psql -tAc \"SELECT * FROM pg_roles WHERE rolname='#{node['db']['user']['name']}'\" | wc -l`.chomp == "1" }
end

execute "create new postgres database" do
  user "postgres"
  command "psql -c \"create database #{node['db']['name']} owner #{node['db']['user']['name']};\""
  not_if { `-u postgres psql -tAc \"SELECT * FROM pg_database WHERE datname='#{node['db']['name']}'\" | wc -l`.chomp == "1" }
end

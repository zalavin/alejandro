execute "apt-get update"

package "vim"
package "htop"
package "telnet"
package "postfix"
package "git-core"
package "zlib1g-dev"
package "libssl-dev"
package "libreadline-dev"
package "libyaml-dev"
package "libsqlite3-dev"
package "sqlite3"
package "libxml2-dev"
package "libxslt1-dev"
package "libpq-dev"
package "build-essential"
package "tree"

bash "set timezone" do
  code <<-EOH
    echo 'Europe/Kiev' > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata
  EOH
end

bash "set locale" do
  code <<-EOH
    echo 'LANGUAGE="en_US.utf8"' >> /etc/default/locale
    echo 'LC_ALL="en_US.utf8"' >> /etc/default/locale
  EOH
end

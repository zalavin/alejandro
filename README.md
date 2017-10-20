Before setting up the server be sure to change all the needed configs for chef
Check out prep_env.sh file for more detailed description

To set up the server with all needed configuration run the command:
  sh prep_env.sh XXX.XXX.XXX
  XXX.XXX.XXX.XXX - is the ip address of the server

In order to handle ssh keys locally and send in to the server run:
  bash add_ssh_key $host $ip $user $port(default = 22)

Feel free to contribute to the project

The list of future improvements:
- add monit for unicorn and nginx;
- move unicorn.rb file from app into template;
- move creation and deletion of ssh key from bash to chef;
setup new site steps:

1. Create project folder in config/apps
1.1. Configure application.yml file
1.2. Configure assets/common images
1.3. Add to public analytics files

2.
apps/project/config

apps/project/public

cap production 'project' deploy:setup:all

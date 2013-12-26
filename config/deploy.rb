require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

#set :domain, 'root@112.124.57.28'
set :domain, 'zhangw@localhost'
#set :deploy_to, '/alidata1/xiyou/apps/toyouface'
set :deploy_to, '/tmp/zhangw'
#set :app_path,   "#{deploy_to}/#{current_path}"
set :repository, 'git@github.com:zwwz22/toyouface.git'
set :branch, 'master'
#set :rvm_path, '/usr/local/rvm/scripts/rvm'
set :rvm_path, '/home/zhangw/.rvm/scripts/rvm'
#set :keep_releases, 2

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log']

# Optional settings:
#   set :user, 'zhangw'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#set :ssh_options, '-A'

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  #invoke :'rvm:use[ruby-1.9.3-p448@default]'
  invoke :'rvm:use[ruby-2.0.0-p195@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/tmp/pids"]


  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    #invoke :'rails:db_migrate'
    #invoke :'rails:assets_precompile'

    #to :launch do
    #  invoke :restart
      #queue "cd #{deploy_to}/current/"
      #queue "rails s -p 3001"
      #queue "touch #{deploy_to}/tmp/restart.txt"
    #end
  end
end

task :restart => :environment do
  queue  %[echo "-----> restart unicorn'."]
  queue "rm #{deploy_to}/deploy.lock"
  #queue "kill -9 `cat /alidata1/xiyou/apps/toyouface/current/tmp/pids/server.pid`"
  queue! %[  ps aux |grep unicorn|grep -v grep |awk '{print $2}'|xargs kill -9 ]
  queue! %[cd  "#{deploy_to}/current"]
  #queue "rails s -p 3001"
  queue "unicorn -D -c config/unicorn.rb"
  queue  %[echo "-----> restart nginx'."]
  queue "touch #{deploy_to}/tmp/restart.txt"
  queue 'sudo service nginx restart'
  queue  %[echo "-----> all ok'."]
  #invoke :deploy
end

task :start => :environment do
    queue  %[echo "----->#{deploy_to} Be sure to edit 'shared/config/database.yml'."]
    queue "cd #{deploy_to}/current/"
    queue  %[echo "----->#{deploy_to} Be sure to edit 'shared/config/database.yml'."]
    queue "rails s -p 3001"
    #queue "touch #{deploy_to}/tmp/restart.txt"
    #invoke :deploy
end
# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers


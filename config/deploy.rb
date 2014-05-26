# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'Lets2gether'
set :repo_url, 'git@github.com:AndreyPristupa/Lets2Gether.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/positivegame/webapps/lets2gether'

# Default value for :scm is :git
set :scm, :git

role :app, 'web371.webfaction.com'
role :web, 'web371.webfaction.com'
role :db,  'web371.webfaction.com', :primary => true

set :user, 'positivegame'
set :password, 'igbkbdbkbnhb4'
set :scm_username, 'AndreyPristupa'
set :scm_password, 'igbkbdbkbnhb4'
set :use_sudo, false
set :ssh_options, { :forward_agent => true }
set :tmp_dir, '/home/positivegame/123'
#ssh_options[:keys] = 'C:/Users/Andrey/.ssh/'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart nginx'
  task :restart do
    run "#{deploy_to}/bin/restart"
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

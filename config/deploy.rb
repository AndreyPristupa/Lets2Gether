# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'Lets2gether'
set :repo_url, 'https://github.com/AndreyPristupa/Lets2Gether.git'

set :deploy_to, '/home/positivegame/webapps/lets2gether'

set :scm, :git


role :app, 'web371.webfaction.com'
role :web, 'web371.webfaction.com'
role :db,  'web371.webfaction.com', :primary => true

set :user, 'positivegame'
set :password, 'igbkbdbkbnhb4'
set :scm_username, 'AndreyPristupa'
set :scm_password, 'igbkbdbkbnhb4'
set :scm_passphrase, 'trance'
set :use_sudo, false
set :ssh_options, { :forward_agent => false }
set :tmp_dir, '/home/positivegame/123'

set :log_level, :info
set :keep_releases, 3

set :default_environment, [
    'PATH' => "#{deploy_to}/bin:$PATH",
    'GEM_HOME' => "#{deploy_to}/gems",
    'RUBYLIB'  => "#{deploy_to}/lib"
]
namespace :deploy do

  desc 'Run Bundle install'
  task :bundle do
    on roles(:app),in: :sequence, wait: 5 do
      execute 'cd $HOME/webapps/lets2gether && export GEM_HOME=$PWD/gems && export RUBYLIB=$PWD/lib && export PATH=$PWD/bin:$PATH && cd $HOME/webapps/lets2gether/current && bundle install && rake db:migrate'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute "#{deploy_to}/bin/restart"
    end
  end

  after :publishing, :bundle
  after :bundle, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      #within release_path do
      #   execute :rake, 'cache:clear'
      #end
    end
  end
end

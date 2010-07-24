set :application, "anything"
set :server_name, "niranjangp.xen.prgmr.com"
set :user, "rails"
set :repository,  "git@#{server_name}:hackday"
set :scm, :git
set :scm_username, "git"
set :runner, 'rails'
set :use_sudo, false
set :branch, "master"
set :deploy_via, :checkout
set :git_shallow_clone, 1
set :deploy_to, "/var/www/rails/#{application}"
set :chmod755, "app config db lib public vendor script script/* public/ disp*"
role :app, server_name
role :web, server_name
role :db, server_name, :primary => true
set :rails_env, 'production'

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :restart, :roles => :app do
    run "mkdir #{deploy_to}/current/anything2/tmp"
    run "touch #{deploy_to}/current/anything2/tmp/restart.txt"
  end
end

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

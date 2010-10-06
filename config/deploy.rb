set :application, "178.79.139.120"
set :location, "shopping_cart"
set :repository,  "git@github.com:dragontech/shopping-cart.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :scm, "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "mihai"
set :deploy_to, "/srv/www/#{location}"
set :port, 60000

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :web, application                          # Your HTTP server, Apache/etc
role :app, application                          # This may be the same as your `Web` server
role :db,  application, :primary => true        # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end


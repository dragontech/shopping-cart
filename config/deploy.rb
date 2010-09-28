set :application, "184.106.240.136"
set :location, "shopping_cart"
set :repository,  "git@github.com:dragontech/shopping-sart.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :scm, "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "mihai"
set :deploy_to, "/home/mihai/public_html/#{location}"
set :port, 60000

default_run_options[:pty] = true

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

 desc "Configure VHost"
 task :config_vhost do
   vhost_config =<<-EOF
<VirtualHost *:80>
ServerName blog.pggbee.com
DocumentRoot #{deploy_to}/public
</VirtualHost>
EOF
   put vhost_config, "src/vhost_config"
   sudo "mv src/vhost_config /etc/apache2/sites-available/#{application}"
   sudo "a2ensite #{application}"
 end

# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "tpis"
set :repo_url, "git@github.com:falsealarm-wk/tpis.git"
set :deploy_to, '/home/okatav/tpis'
set :deploy_user, "okatav"
set :bundle_flags, "--no_deployment"
set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", "config/.env", "config/sidekiq.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# namespace :deploy do

#   task :rm_mingw32 do
#     puts "    modifying Gemfile.lock ... removing mingw32 platform ext. before re-bundling on LINUX"
#     run "sed 's/-x86-mingw32//' #{release_path}/Gemfile.lock > #{release_path}/Gemfile.tmp && mv #{release_path}/Gemfile.tmp #{release_path}/Gemfile.lock"
#     run "sed -n '/PLATFORMS/ a\  ruby' #{release_path}/Gemfile.lock"
#   end

# end

# before("bundler:install", "deploy:rm_mingw32")

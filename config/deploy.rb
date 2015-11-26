# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'rendezvous'
set :repo_url, 'git@github.com:tadyjp/rendezvous.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, ENV['REVISION'] || 'master'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/rendezvous'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w(config/database.yml config/settings.yml)

# Default value for linked_dirs is []
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :rbenv_type, :system
set :rbenv_ruby, '2.1.4'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value

# namespace :deploy do
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # Your restart mechanism here, for example:
#       execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   after 'deploy:publishing', 'deploy:restart'
#   after :publishing, :restart

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       within release_path do
#         execute :rake, 'tmp:clear'
#       end
#     end
#   end
# end

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    # invoke 'unicorn:restart'
  end
end

namespace :linked_files do
  desc 'Touches all your linked files'
  task :touch do
    on release_roles :all do
      within shared_path do
        fetch(:linked_files, []).each do |file|
          execute :touch, file
          info "Touched: #{file}"
        end
      end
    end
  end

  before 'deploy:check:linked_files', 'linked_files:touch'
end

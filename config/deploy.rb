# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "rails_app"
set :repo_url, "git@bitbucket.org:augustosamame/scraping.git"

set :user, 'deploy'

set :branch, :master
set :deploy_to, '/home/deploy/rails_app'
set :rails_env, 'production'
set :linked_files, %w{config/master.key} #config/database.yml config/credentials.yml.enc
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :keep_releases, 3
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.5.1' # Edit this if you are using MRI Ruby

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 4]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

set :logtail_files, %w( /var/log/syslog )
set :logtail_lines, 100

set :delayed_job_server_role, :worker
set :delayed_job_args, "-n 2"

#set :rollbar_token, ENV['ROLLBAR_SERVER_TOKEN']
#set :rollbar_env, Proc.new { fetch :stage }
#set :rollbar_role, Proc.new { :app }
#set :rollbar_sourcemaps_minified_url_base, "https://www.devtechperu.com"

#set :env_file, '.env'

set :pty, false
#set :sidekiq_config => nil

#set :aws_access_key_id,     ENV['AWS_ACCESS_KEY_ID']
#set :aws_secret_access_key, ENV['AWS_SECRET_ACCESS_KEY']
#set :aws_region,            ENV['AWS_REGION']

#set :aws_no_reboot_on_create_ami, false
#set :aws_autoscale_instance_size, 't2.micro'

#set :aws_launch_configuration_detailed_instance_monitoring, true
#set :aws_launch_configuration_associate_public_ip, true

after "deploy", "puma:start"

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'delayed_job:restart'
  end
end

#load 'lib/capistrano/tasks/seed.rb'
namespace :db do
  desc 'Runs DB Migration'
  task :nuke do
    on primary :db do
      within release_path do
        with rails_env: fetch(:stage) do
          #if you want to nuke db withot drop each time a new version is deployed, comment out the following line
          #execute :rake, 'db:reset db:migrate db:seed'
          execute :rake, 'db:migrate db:seed'
          #execute :rake, 'db:seed'
        end
      end
    end
  end
end

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'tmp:cache:clear'
      end
    end
  end

end

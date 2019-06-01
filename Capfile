# Load DSL and set up stages
require "capistrano/setup"
# Include default deployment tasks
require "capistrano/deploy"
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
install_plugin Capistrano::Puma
require 'capistrano/logtail'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require 'capistrano/rails/console'
require 'capistrano-db-tasks'
require 'capistrano/npm'
# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'

# rails includes asset compilingw hich crashes on api mode
# require 'capistrano/rails'
require 'capistrano/bundler'
# require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

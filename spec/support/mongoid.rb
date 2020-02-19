require 'pathname'
require 'mongoid'
root    = Pathname(File.expand_path('../../test_app', __dir__))
version = Mongoid::VERSION.to_i

current_config = root.join("config/mongoid.#{version}.yml").read
config_file    = root.join('config/mongoid.yml')
config_file.open('w') { |c| c << current_config }

Mongoid.load!(config_file, :test)
Mongo::Logger.logger.level = ::Logger::FATAL

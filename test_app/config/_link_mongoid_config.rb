require 'pathname'
require 'mongoid'
root    = Pathname(File.expand_path('../..', __FILE__))
version = Mongoid::VERSION.to_i

current_config = root.join("config/mongoid.#{version}.yml").read
config_file    = root.join('config/mongoid.yml')
config_file.open('w') {|c| c << current_config }

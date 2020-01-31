# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_admin/mongoid/version'

Gem::Specification.new do |gem|
  gem.authors = ['Jesus Alcaraz', 'Elia Schito', 'Nic Boie', 'JD Guzman',
                 'Grzegorz Jakubiak']
  gem.email = %w(jesusalc@gmail.com elia@schito.me)
  gem.description = 'ActiveAdmin hacks Mongoid (some features are disabled)'
  gem.summary = 'ActiveAdmin hacks to support Mongoid'
  gem.homepage = ''

  gem.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name = 'activeadmin-mongoid'
  gem.require_paths = ['lib']
  gem.version = ActiveAdmin::Mongoid::VERSION
  gem.license = 'MIT'

  gem.required_ruby_version = '>= 2.5'

  gem.add_runtime_dependency 'mongoid', '>= 6.0', '< 8.a'
  gem.add_runtime_dependency 'activeadmin', '>= 1.4.3'
  gem.add_runtime_dependency 'kaminari-mongoid'
  gem.add_runtime_dependency 'jquery-rails'
  gem.add_runtime_dependency 'sass-rails', '>= 3.1.4'

  gem.add_development_dependency 'rspec-rails', '~> 3.6'
end

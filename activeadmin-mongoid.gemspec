# coding: utf-8
require File.expand_path('../lib/active_admin/mongoid/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Elia Schito']
  gem.email         = ['elia@schito.me']
  gem.description   = %q{ActiveAdmin hacks to support Mongoid (some ActiveAdmin features are disabled)}
  gem.summary       = %q{ActiveAdmin hacks to support Mongoid}
  gem.homepage      = ''

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'activeadmin-mongoid'
  gem.require_paths = ['lib']
  gem.version       = ActiveAdmin::Mongoid::VERSION
  gem.license       = 'MIT'

  gem.add_runtime_dependency 'mongoid',     '>= 2.4'
  gem.add_runtime_dependency 'activeadmin', '~> 0.4'
  gem.add_runtime_dependency 'sass-rails',  ['~> 3.1', '>= 3.1.4']
end

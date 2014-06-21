source 'https://rubygems.org'

# Declare your gem's dependencies in activeadmin-mongoid.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec


# Test app stuff
gem 'rails',        '~> 4.0.5'

# Waiting for the release
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'mongoid',     github: 'mongoid/mongoid'

gem 'sass-rails',   '~> 4.0.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'devise'

# Bundler hacks
gem 'railties',     '~> 4.0.5' # forced to overcome coffee-rails

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder',     '~> 1.2'

group :doc do
  gem 'sdoc', require: false
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'simplecov', require: false
end

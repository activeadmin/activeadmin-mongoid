source 'https://rubygems.org'

# Declare your gem's dependencies in activeadmin-mongoid.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec


# Test app stuff
case ENV['RAILS_VERSION']
when '4'
  gem 'rails',        '~> 4.0.0'

  # Waiting for the release
  gem 'activeadmin', github: 'gregbell/active_admin', branch: 'rails4'
  gem 'mongoid', github: 'mongoid/mongoid'

  gem 'sass-rails',   '~> 4.0.0'
  gem 'uglifier',     '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'

  # Bundler hacks
  gem 'railties',     '~> 4.0.0' # forced to overcome coffee-rails

  gem 'jquery-rails'
  gem 'turbolinks'
  gem 'jbuilder',     '~> 1.2'

  group :doc do
    gem 'sdoc', require: false
  end


else
  gem 'rails', '~> 3.2.6'

  # Gems used only for assets and not required
  # in production environments by default.
  group :assets do
    gem 'sass-rails',   '~> 3.2.3'
    gem 'coffee-rails', '~> 3.2.1'

    # See https://github.com/sstephenson/execjs#readme for more supported runtimes
    # gem 'therubyracer', :platforms => :ruby
    gem 'uglifier', '>= 1.0.3'
  end

  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'jslint'
end


group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'simplecov', require: false
end

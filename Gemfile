source 'https://rubygems.org'

# Declare your gem's dependencies in activeadmin-mongoid.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'ransack', github: 'activerecord-hackery/ransack'
gem 'ransack-mongoid', github: 'activerecord-hackery/ransack-mongoid'

# Test app stuff

gem 'rails', '~> 5.1'
gem 'kaminari', '~> 1.0'
gem 'kaminari-mongoid'

gem 'devise'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '>= 5.0.6'
  gem 'coffee-rails', '~> 4.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jslint'

group :test do
  gem 'pry-rails'
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'simplecov', require: false
end

# ActiveAdmin::Mongoid

ActiveAdmin hacks to support Mongoid.
Some ActiveAdmin features are disabled:

- comments

For more on Mongoid support in ActiveAdmin see [this issue](https://github.com/gregbell/active_admin/issues/26).

## Installation

### Some Gems
Add the following gems to your application's Gemfile:

```ruby
gem 'activeadmin-mongoid'
gem 'devise'
```
Devise is the gem used to managed admin authentication.
The gem is required to force itself ORM configuration.
Else the gem will try to use by default ActiveRecord ORM.

You can safely remove the following lines, since are already activeadmin-mongoid dependencies:

```ruby
gem 'activeadmin'
gem 'meta_search', '>= 1.1.0.pre'
gem 'sass-rails',  ['~> 3.1', '>= 3.1.4']
```

### Remove Application Dependencies
In your config/application.rb, replace :

```ruby
require 'rails/all'
```

with :

```ruby
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"
```

rails/all includes elements requiring ActiveRecord::Connection ...

### Bundle & Crank

Execute:

    $ bundle
    $ rails g devise:install
    $ rails g active_admin:install

Check that the generated initializers/devise.rb file requires mongoid orm.
You may find a line like this :

```ruby
require 'devise/orm/mongoid'
```

Then create the admin user:

    $ rails console
    >> AdminUser.create :email => 'admin@example.com', :password => 'password', :password_confirmation => 'password'

And that's pretty much it !

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright © 2012 Elia Schito. See LICENSE for details.

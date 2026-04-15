# ActiveAdmin-Mongoid
[![Version         ][rubygems_badge]][rubygems]
![Tests](https://github.com/activeadmin/activeadmin-mongoid/actions/workflows/tests.yml/badge.svg)
![Codecheck](https://github.com/activeadmin/activeadmin-mongoid/actions/workflows/codecheck.yml/badge.svg)

## Updates

ActiveAdmin is holding off on pulling Mongoid support into the core ActiveAdmin application.  This repo was pulled into the ActiveAdmin org from previous work done by Elia Schito, and will be maintained by Grzegorz Jakubiak, Nic Boie, JD Guzman, Elia Schito and other ActiveAdmin and community members.

### Requirements for version 0.7.0
* Ruby 2.2.2 or greater. (Note, ruby-2.4.0 fails specs, see [this issue](https://github.com/DatabaseCleaner/database_cleaner/issues/466))
* Tested working on Rails 5.1.x
### Requirements for version 1.0.0
* Ruby 2.4.0 or greater.
* Tested working on Rails 5.2.3

* Mongoid 6.x (**WARNING**:, using a Mongoid version >= 6.1.x has resulted in a fair amount of errors seen in the wild.  Test your upgrade very carefully with any apps in which you're using this gem with Mongoid >= 6.1.x!)
* ActiveAdmin 1.4.3 or greater
* `ransack-mongoid` - it needs to be explicitly declared in Gemfile, pointing to github's master since it has no releases on rubygems yet.

## Previous versions
* Rails 4.x with Mongoid 5.x use branch rails4-mongoid5
* Rails 4.x with Mongoid 4.x branch rails4
* Mongoid 3.x with older versions of rails use v 0.3.0

## ♻️ INFO

This gem has been brought into the ActiveAdmin org for support and maintenance.

<!-- [![Build Status](https://secure.travis-ci.org/elia/activeadmin-mongoid.svg?branch=master)](http://travis-ci.org/elia/activeadmin-mongoid)
[![Gem Version](https://badge.fury.io/rb/activeadmin-mongoid.svg)](http://badge.fury.io/rb/activeadmin-mongoid) -->

# ActiveAdmin::Mongoid

ActiveAdmin hacks to support Mongoid.
Some ActiveAdmin features are disabled or not working properly:

- comments are disabled by default
- filters are somewhat broken

For more on Mongoid support in ActiveAdmin see [this issue](https://github.com/gregbell/active_admin/issues/26).

## Installation

### Some Gems
Add the following gems to your application's Gemfile, and lock the version:

```ruby
gem 'activeadmin-mongoid', '1.0.0'
gem 'ransack-mongoid', github: 'activerecord-hackery/ransack-mongoid'
```

You can safely remove the following lines, since are already activeadmin-mongoid dependencies:

```ruby
gem 'activeadmin'
```

### Remove Application Dependencies
In your config/application.rb, replace:

```ruby
require 'rails/all'
```

with:

```ruby
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"
```

NOTE: This gem will NOT work if you use both ActiveRecord AND Mongoid in the same app.  rails/all includes elements requiring ActiveRecord::Connection

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

Then create an admin user:

    $ bundle exec rails console
    >> AdminUser.create email: 'admin@example.com', password: 'password', password_confirmation: 'password'

And that's pretty much it !

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright © 2012 Elia Schito. See LICENSE for details.

[rubygems_badge]: https://img.shields.io/gem/v/activeadmin-mongoid.svg
[rubygems]: https://rubygems.org/gems/activeadmin-mongoid

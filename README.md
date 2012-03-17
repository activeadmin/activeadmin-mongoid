# ActiveAdmin::Mongoid

ActiveAdmin hacks to support Mongoid.
Some ActiveAdmin features are disabled:

- comments
- sidebar filters

For more on Mongoid support in ActiveAdmin see [this issue](https://github.com/gregbell/active_admin/issues/26).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activeadmin-mongoid'
```

You can safely remove the following lines, since are already activeadmin-mongoid dependencies:

```ruby
gem 'activeadmin'
gem 'meta_search', '>= 1.1.0.pre'
gem 'sass-rails',  ['~> 3.1', '>= 3.1.4']
```

And then execute:

    $ bundle


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright © 2012 Elia Schito. See LICENSE for details.

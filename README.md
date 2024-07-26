# Seline

Seline is a Ruby gem that provides a simple wrapper for the Seline analytics API. It allows you to easily track events, set user data, and log page views in your Ruby or Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seline'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install seline
```

## Configuration

### For Rails applications

Create an initializer file `config/initializers/seline.rb`:

```ruby
Seline.configure do |config|
  config.token = 'your-api-token'
end
```

### For non-Rails applications

Configure the gem at the start of your application:

```ruby
require 'seline'

Seline.configure do |config|
  config.token = 'your-api-token'
end
```

## Usage

### Tracking events

```ruby
Seline.track(event: 'user: signed up', user_id: 'sk-123', properties: { plan: 'free' })
```

### Setting user data

```ruby
Seline.set_user(user_id: 'sk-123', email: 'john@example.com', properties: { name: 'John Doe' })
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/seline. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Seline project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/seline/blob/master/CODE_OF_CONDUCT.md).
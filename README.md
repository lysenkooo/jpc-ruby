# JPC

This gem implements server-side support for JSON-RPC 2.0 via websockets over EventMachine.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jpc', github: 'lysenkooo/jpc-ruby'
```

And then execute:

    $ bundle

## Usage

First of all, you need to create handler.

```ruby
class MainHandler < JPC::Handler
  def test_hash(params)
    "Success with #{params.inspect}"
  end

  def test_array(first, second, third)
    "Success with #{first} #{second} #{third}"
  end

  private

  def allowed_methods
    %w[test_hash test_array]
  end
end
```

Now you can use JSON-RPC 2.0 client to send messages to your websocket.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lysenkooo/jpc-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

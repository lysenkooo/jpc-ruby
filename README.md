# JPC

This gem implements server-side support for JSON-RPC 2.0 via websockets over EventMachine.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jpc'
```

And then execute:

    $ bundle

## Usage

First of all, you need to create handler.

```ruby
class MainHandler < JPC::Handler
  def test
    'Success!'
  end

  private

  def allowed_methods
    %w[test]
  end
end
```

After that you need to run websocket in your EventMachine.

```ruby
EventMachine.run do
  handler = MainHandler.new
  JPC::Socket.run(handler. host: '0.0.0.0', port: 8090)
end
```

After that you can use JSON-RPC 2.0 client to send messages to your websocket.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lysenkooo/jpc-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

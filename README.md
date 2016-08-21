# JPC

This gem implements server-side support for JSON-RPC 2.0 via websockets over EventMachine.

However it implements channels support to broadcast functions like ActionCable.

## Installation

Add follow line to your application's Gemfile:

```ruby
gem 'jpc', github: 'lysenkooo/jpc-ruby'
```

And then execute:

    $ bundle

## Usage

First of all you need to create handler.

```ruby
class MainHandler < JPC::Handler
  def test_hash_params(params)
    "Success with #{params.inspect}"
  end

  def test_array_params(first, second, third)
    "Success with #{first} #{second} #{third}"
  end

  def broadcast_message(message)
    @dispatcher.cast('main_channel', message)
  end

  private

  def procedures
    %w[test_hash_params test_array_params broadcast_message]
  end
end
```

After that you should create invoker instance and set up forwarding JSON
messages from your client.

```ruby
EventMachine.run do
  dispatcher = JPC::Dispatcher.new

  EM::WebSocket.run(host: '0.0.0.0', port: 8090) do |ws|
    handler = MainHandler.new(ws, dispatcher)
    rpc = JPC::Invoker.new(handler)

    ws.onmessage do |message|
      response = rpc.invoke(message)
      ws.send(response)
    end

    ws.onerror do |error|
      backtrace = error.backtrace.join("\n")
      puts "#{error}\n#{backtrace}\n"
    end
  end
end
```

Now you can use JSON-RPC 2.0 client to send messages to your websocket.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lysenkooo/jpc-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

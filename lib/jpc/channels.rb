module JPC
  module Channels
    module Initializer
      def initialize(*args)
        @channels = {}
        super(*args)
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
    end

    def subscribe(ws, channel)
      @channels[channel.to_sym] ||= []
      @channels[channel.to_sym] << ws

      { channel: channel, status: 'subscribed' }
    end

    def unsubscribe(ws, channel)
      fail "Channel #{channel} not found" unless @channels[channel.to_sym]

      @channels[channel.to_sym] -= [ws]

      { channel: channel, status: 'unsubscribed' }
    end

    def cast(channel, payload)
      message = make_message(channel: channel, payload: payload)

      sent = 0

      @channels[channel.to_sym] && @channels[channel.to_sym].each do |ws|
        ws.send(message)
        sent += 1
      end

      { channel: channel, sent: sent }
    end
  end
end

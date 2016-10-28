module JPC
  class Dispatcher
    include JPC::Helpers

    def subscribe(ws, channel)
      channels[channel.to_sym] ||= []
      channels[channel.to_sym].push(ws) unless channels[channel.to_sym].include?(ws)

      { channel: channel, status: 'subscribed' }
    end

    def unsubscribe(ws, channel)
      raise "Channel #{channel} not found" unless channels[channel.to_sym]

      channels[channel.to_sym].each_with_index do |object, index|
        channels[channel.to_sym].delete_at(index) if object == ws
      end

      { channel: channel, status: 'unsubscribed' }
    end

    def cast(channel, payload)
      message = make_message(channel: channel, payload: payload)

      sent = 0

      channels[channel.to_sym] && channels[channel.to_sym].each do |ws|
        ws.send(message)
        sent += 1
      end

      { channel: channel, sent: sent }
    end

    private

    def channels
      @channels ||= {}
    end
  end
end

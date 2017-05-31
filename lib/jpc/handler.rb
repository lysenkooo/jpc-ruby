module JPC
  class Handler
    attr_accessor :token

    def initialize(ws, dispatcher)
      @ws = ws
      @dispatcher = dispatcher
    end

    def ping(params = {})
      "pong #{params.inspect}"
    end

    def subscribe(channel)
      @dispatcher.subscribe(@ws, channel)
    end

    def unsubscribe(channel)
      @dispatcher.unsubscribe(@ws, channel)
    end

    private

    def allowed?(method)
      %w(ping subscribe unsubscribe).include?(method)
    end
  end
end

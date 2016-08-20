class JPC::Handler
  def initialize(ws, dispatcher)
    @ws = ws
    @dispatcher = dispatcher
  end

  def ping(params = {})
    "pong #{params}"
  end

  def subscribe(channel)
    @dispatcher.subscribe(@ws, channel)
  end

  def unsubscribe(channel)
    @dispatcher.unsubscribe(@ws, channel)
  end

  private

  def allowed_methods
    procedures + %w(ping subscribe unsubscribe)
  end

  def procedures
    []
  end
end

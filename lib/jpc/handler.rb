class JPC::Handler
  def ping
    'pong'
  end

  private

  def allowed_methods
    %w[ping]
  end
end

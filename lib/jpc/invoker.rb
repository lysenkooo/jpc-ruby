class JPC::Invoker
  include JPC::Helpers

  def initialize(handler)
    @handler = handler
  end

  def invoke(json)
    request = Oj.load(json)
    response = execute(request)
  end

  private

  def execute(request)
    method = request['method']

    fail "Method #{method} not allowed" unless method_allowed?(method)

    @handler.token = request['token'] if request['token']

    if @handler.respond_to?(:authorized?)
      fail JPC::Errors::UnauthorizedError unless @handler.authorized?(method)
    end

    if request['params'].is_a?(Array)
      result = @handler.public_send(method, *request['params'])
    elsif %w(Hash String Integer).include?(request['params'].class.name)
      result = @handler.public_send(method, request['params'])
    else
      result = @handler.public_send(method)
    end

    make_result(request['id'], result)
  rescue => e
    case e.class.name
    when 'JPC::Errors::UnauthorizedError'
      code = 32001
    else
      code = 32000
    end

    make_error(
      request['id'],
      code,
      "Method #{method}: #{e.message}. See #{e.backtrace[0]}"
    )
  end

  def method_allowed?(name)
    @handler.send(:allowed_methods).include?(name.to_s)
  end
end

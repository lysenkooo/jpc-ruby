class JPC::Invoker
  def initialize(handler)
    @handler = handler
  end

  def invoke(json)
    data = execute(json)

    data.merge!({
      jsonrpc: JPC::RPC_VERSION
    })

    make_response(data)
  end

  private

  def parse_request(json)
    Oj.load(json)
  end

  def make_response(data)
    Oj.dump(data, mode: :compat)
  end

  def execute(json)
    request = parse_request(json)

    fail 'Method not specified' unless request['method']
    fail 'Method not allowed' unless method_allowed?(request['method'])
    fail 'Method not found' unless @handler.respond_to?(request['method'])

    if request['params'].is_a?(Array)
      result = @handler.public_send(request['method'], *request['params'])
    elsif request['params'].is_a?(Hash)
      result = @handler.public_send(request['method'], request['params'])
    else
      result = @handler.public_send(request['method'])
    end

    {
      result: result,
      id: request['id']
    }
  rescue => e
    {
      error: { code: -32600, message: e.message },
      id: request && request['id']
    }
  end

  def method_allowed?(name)
    @handler.send(:allowed_methods).include?(name.to_s)
  end
end

module JPC
  class Invoker
    include JPC::Helpers

    def initialize(handler)
      @handler = handler
    end

    def invoke(json)
      request = Oj.load(json)
      execute(request)
    end

    private

    def execute(request)
      method = request['method']

      raise "Method #{method} not allowed" unless method_allowed?(method)

      @handler.token = request['token'] if request['token']

      if @handler.respond_to?(:authorized?)
        raise JPC::Errors::UnauthorizedError unless @handler.authorized?(method)
      end

      result = if request['params'].is_a?(Array)
                 @handler.public_send(method, *request['params'])
               elsif %w(Hash String Integer).include?(request['params'].class.name)
                 @handler.public_send(method, request['params'])
               else
                 @handler.public_send(method)
               end

      make_result(request['id'], result)
    rescue => e
      code = case e.class.name
             when 'JPC::Errors::UnauthorizedError'
               32001
             else
               32000
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
end

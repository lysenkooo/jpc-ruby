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

      raise "Method #{method} is not allowed" unless @handler.send(:allowed?, method)

      @handler.token = request['token'] if request['token']

      result = if request['params'].is_a?(Array)
                 @handler.public_send(method, *request['params'])
               elsif %w(Hash String Integer).include?(request['params'].class.name)
                 @handler.public_send(method, request['params'])
               else
                 @handler.public_send(method)
               end

      make_result(request['id'], result)
    rescue => e
      make_error(
        request['id'],
        e.class.name,
        "Method #{method}: [#{e.class.name}] #{e.message} @ #{e.backtrace[0]}"
      )
    end
  end
end

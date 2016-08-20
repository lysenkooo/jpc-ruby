module JPC
  module Helpers
    def make_message(data)
      message = { jsonrpc: JPC::RPC_VERSION }.merge!(data)
      Oj.dump(message, mode: :compat)
    end

    def make_response(id, data)
      response = { id: id }.merge!(data)
      make_message(response)
    end

    def make_result(id, result)
      make_response(id, result: result)
    end

    def make_error(id, message, code = -32600)
      error = {
        code: code,
        message: message
      }

      make_response(id, error: error)
    end
  end
end

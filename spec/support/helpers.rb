module Helpers
  def make_request(data)
    message = { jsonrpc: JPC::RPC_VERSION }.merge!(data)
    Oj.dump(message, mode: :compat)
  end
end

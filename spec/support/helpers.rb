module Helpers
  def make_request(method, data)
    data[:jsonrpc] = '2.0'
    data[:method] = method.to_s

    Oj.dump(data, mode: :compat)
  end

  def parse_json(json)
    Oj.load(json)
  end
end

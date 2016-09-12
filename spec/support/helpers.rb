module Helpers
  def make_request(method, data)
    data.merge!(
      jsonrpc: '2.0',
      method:  method.to_s
    )

    Oj.dump(data, mode: :compat)
  end

  def parse_json(json)
    Oj.load(json)
  end
end

describe JPC::Invoker do
  let(:ws) { FakeSocket.new }
  let(:dispatcher) { JPC::Dispatcher.new }
  let(:handler) { JPC::Handler.new(ws, dispatcher) }
  let(:invoker) { JPC::Invoker.new(handler) }

  it 'return right json for ping method' do
    request_id = 1
    json = make_request(:ping, id: request_id, params: 'test')
    result_message = invoker.invoke(json)
    result = Oj.load(result_message)

    expect(result['jsonrpc']).to eq '2.0'
    expect(result['id']).to eq request_id
    expect(result['result']).to eq 'pong test'
    expect(result['error']).to be_nil
  end

  it 'return error for not allowed method' do
    request_id = 2
    json = make_request(:destroy, id: request_id, params: 'all')
    result_message = invoker.invoke(json)
    result = Oj.load(result_message)

    expect(result['jsonrpc']).to eq '2.0'
    expect(result['id']).to eq request_id
    expect(result['result']).to be_nil
    expect(result['error']['code']).to eq 32000
  end
end

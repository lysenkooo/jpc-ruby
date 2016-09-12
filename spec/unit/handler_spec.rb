describe JPC::Handler do
  let(:ws) { FakeSocket.new }
  let(:dispatcher) { JPC::Dispatcher.new }
  let(:handler) { JPC::Handler.new(ws, dispatcher) }

  it 'return right answer for ping method with params as string' do
    result = handler.ping 'test'
    expect(result).to eq 'pong test'
  end

  it 'return right answer for ping method with params as string' do
    result = handler.ping(['one', 'two'])
    expect(result).to eq 'pong ["one", "two"]'
  end

  it 'return right answer for ping method with params as string' do
    result = handler.ping(one: 'two', three: 'four', five: 6)
    expect(result).to eq 'pong {:one=>"two", :three=>"four", :five=>6}'
  end

  it 'broadcasts message' do
    handler.subscribe(:test_channel)

    dispatcher.cast(:test_channel, 'TestPayload')
    message = parse_json(ws.data)
    expect(message['payload']).to eq 'TestPayload'

    dispatcher.cast(:test_channel, 'AnotherPayload')
    message = parse_json(ws.data)
    expect(message['payload']).to eq 'AnotherPayload'

    handler.unsubscribe(:test_channel)

    dispatcher.cast(:test_channel, 'ThirdPayload')
    message = parse_json(ws.data)
    expect(message['payload']).to eq 'AnotherPayload'
  end
end

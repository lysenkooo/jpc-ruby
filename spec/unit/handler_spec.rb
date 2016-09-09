require 'spec_helper'

describe JPC::Handler do
  let(:handler) { JPC::Handler.new }

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
end

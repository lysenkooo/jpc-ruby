require 'spec_helper'

describe JPC do
  it 'has a version number' do
    expect(JPC::VERSION).not_to be nil
  end

  it 'has a right rpc version number' do
    expect(JPC::RPC_VERSION).to eq '2.0'
  end
end

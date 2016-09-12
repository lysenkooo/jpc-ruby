$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jpc'
require 'support/helpers'
require 'support/fake_socket'

RSpec.configure do |config|
  config.include Helpers
end

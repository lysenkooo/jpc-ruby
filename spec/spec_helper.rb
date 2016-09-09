$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jpc'
require 'support/helpers'

RSpec.configure do |config|
  config.include Helpers
end

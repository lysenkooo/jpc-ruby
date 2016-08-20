# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jpc/version'

Gem::Specification.new do |spec|
  spec.name          = "jpc"
  spec.version       = JPC::VERSION
  spec.authors       = ["Denis Lysenko"]
  spec.email         = ["d@lysenkooo.ru"]

  spec.summary       = %q{JPC is JSON RPC Ruby Library.}
  spec.description   = %q{This library provide possibility to handle JSON requests.}
  spec.homepage      = "http://lysenkooo.ru"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "oj"
end

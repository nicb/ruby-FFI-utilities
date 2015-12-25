# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'FFI/utilities/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby-FFI-utilities'
  spec.version       = FFI::Utilities::VERSION
  spec.authors       = ['Nicola Bernardini']
  spec.email         = ['n.bernardini@conservatoriosantacecilia.it']

  spec.summary       = %q{Ruby FFI Utilities}
  spec.description   = %q{Utilities for the FFI (Foreign Function Interface) library for Ruby}
  spec.homepage      = 'https://github.com/nicb/ruby-FFI-utilities'


  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'ffi'
end

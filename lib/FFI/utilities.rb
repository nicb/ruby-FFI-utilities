require 'ffi'

module FFI
  module Utilities
    PATH = File.expand_path(File.join('..', 'utilities'), __FILE__)
  end
end

%w(
  version
  argv
).each { |f| require File.join(FFI::Utilities::PATH, f) }

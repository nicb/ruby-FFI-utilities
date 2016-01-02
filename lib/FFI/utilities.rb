require 'ffi'

module FFI
  module Utilities
    PATH = File.expand_path(File.join('..', 'utilities'), __FILE__)
  end
end

%w(
  version
  deprecated
  suffixes
  set_argv
  set_string
  struct_extensions
  struct
).each { |f| require File.join(FFI::Utilities::PATH, f) }

if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
	require 'simplecov'
  SimpleCov.start
end
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'FFI/utilities'
require 'byebug'

SPEC_FIXTURE_PATH = File.expand_path(File.join('..', 'fixtures'), __FILE__)
C_FIXTURE_PATH = File.join(SPEC_FIXTURE_PATH, 'C')

module FFI
  module Utilities
    module Test

      extend FFI::Library
      ffi_lib File.join(C_FIXTURE_PATH, 'libtest.so')

      attach_function :argv_test, [:int, :pointer, :pointer], :int

    end
  end
end

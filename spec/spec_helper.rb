#if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/lib/tasks/'
    add_filter '/lib/FFI/utilities/suffixes.rb' # partially obsolete
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      CodeClimate::TestReporter::Formatter
    ]
  end
# else
# 	require 'simplecov'
#   SimpleCov.start do
#     add_filter '/spec/'
#     add_filter '/lib/tasks/'
#     add_filter '/lib/FFI/utilities/suffixes.rb' # partially obsolete
#   end
# end
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'FFI/utilities'
require 'byebug'

#
# Some tests are brittle and broken even in the upstream FFI library, so we
# won't run them here too (unless we get them to work of course)
#
RSpec.configure do |c|
  c.filter_run_excluding :broken => true, :obsolete => true
end

SPEC_FIXTURE_PATH = File.expand_path(File.join('..', 'fixtures'), __FILE__)
C_FIXTURE_PATH = File.join(SPEC_FIXTURE_PATH, 'C')

module FFI
  module Utilities
    module Test

      extend FFI::Library
      ffi_lib File.join(C_FIXTURE_PATH, FFI.map_library_name('test'))

      attach_function :set_argv_test, [:int, :pointer, :pointer], :int
      attach_function :set_string_test, [:pointer, :pointer], :int

    end
  end
end

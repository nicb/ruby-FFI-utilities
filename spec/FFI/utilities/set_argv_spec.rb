require 'spec_helper'

describe 'FFI::Utilities.set_argv' do

  it 'should return the input arguments on a second array' do
    arguments = ['test1', 'test2', 'test3' ]
    argc = arguments.size
    result = FFI::MemoryPointer.new(:pointer, argc)
    expect(res = FFI::Utilities::Test.set_argv_test(argc, FFI::Utilities.set_argv(arguments), result)).to eq(0)
    expect(result.get_array_of_string(0, argc)).to eq(arguments)
  end

end

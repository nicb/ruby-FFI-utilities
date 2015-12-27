require 'spec_helper'

describe 'FFI::Utilities.set_string' do

  it 'should return the input argument on a second array' do
    argument = 'test 1'
    result = FFI::MemoryPointer.new(:pointer, 1)
    expect(res = FFI::Utilities::Test.set_string_test(FFI::Utilities.set_string(argument), result)).to eq(0)
    expect(result.get_array_of_string(0, 1).first).to eq(argument)
  end

end

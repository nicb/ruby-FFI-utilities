require 'spec_helper'

describe 'FFI::Utilities.deprecated' do

  it 'should write the message to standard error' do
    begin
      #
      # we divert STDERR to a StringIo
      #
      stderr_backup = $stderr.dup
      $stderr = sio = StringIO.new
      test_message = 'test message' 
      expect(FFI::Utilities.deprecated(test_message)).to eq(nil)
      sio.rewind
      expect(sio.read.chomp).to eq("WARNING: DEPRECATED: #{test_message}. This will soon be removed from sources")
    ensure
      $stderr = stderr_backup.dup
    end
  end

end

module FFI

  module Utilities

    class << self

      #
      # <tt>set_string(str)</tt>
      #
      # creates the appropriate +FFI::MemoryPointer+ from a +ruby+ string
      # passed as argument
      #
      def set_string(str)
        FFI::MemoryPointer.from_string(str)
      end

    end

  end

end

module FFI

  module Utilities

    class << self

      #
      # <tt>set_argv(array_of_strings)</tt>
      #
      # creates the appropriate +FFI::MemoryPointer+ out of a +ruby+ array of
      # strings
      #
      def set_argv(array_of_strings)
        str_array = []
        array_of_strings.each { |str| str_array << FFI::MemoryPointer.from_string(str) }
        str_array << nil
      
        res = FFI::MemoryPointer.new(:pointer, str_array.size)
        str_array.each_with_index { |p, i| res[i].put_pointer(0,  p) }
      
        res
      end

    end

  end

end

module FFI

  module Utilities

    class << self

      def deprecated(msg)
        $stderr.puts("WARNING: DEPRECATED: #{msg}. This will soon be removed from sources")
      end

    end

  end

end

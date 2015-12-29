module FFI

  module Utilities

    class UnknownPlatform < StandardError
      def initialize(msg)
        ext_msg = [msg, "unknown platform #{RUBY_PLATFORM}"].join(': ')
        super(ext_msg)
      end
    end

    class << self

      def library_suffix
        res = case RUBY_PLATFORM
              when /linux/i then '.so'
              when /darwin/i then '.dylib'
              when /windows/i then '.dll'
              else raise UnknownPlatform.new('library_suffix')
        end
      end

      def object_suffix
        res = case RUBY_PLATFORM
              when /linux/i then '.o'
              when /darwin/i then '.o'
              when /windows/i then '.obj'
              else raise UnknownPlatform.new('object_suffix')
        end
      end

    end

  end

end


module FFI
  module Utilities
    #
    # <tt>FFI::Utilities::Struct</tt> and <tt>FFI::Utilities::ManagedStruct</tt>
    # *may not* be called with the +new+ method (because it is +private+ in
    # these classes. Users may use the <tt>create(*args) { |args| ...  }</tt>
    # method and block for initialization purposes
    #
    class Struct < FFI::Struct

      include FFI::Utilities::StructExtensions

      private_class_method :new

      private :struct_initialize

    end

    class ManagedStruct < FFI::ManagedStruct

      include FFI::Utilities::StructExtensions

      private_class_method :new

      private :struct_initialize

    end

  end
end

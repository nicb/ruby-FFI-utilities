module FFI
  module Utilities

    module StructExtensions

      class NoLayout < StandardError; end
      class NotALayoutMember < StandardError; end

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods

        #
        # <tt>create(*args) [{ |this_object, args| ... }]</tt>
        #
        # does all the necessary FFI memory housekeeping for data structures
        # and then passes a pointer to self and its arguments to a block.
        #
        # Also, this method may be overridden in subclasses and then called
        # with <tt>super()</tt> if necessary.
        #
        def create(*args)
          mp = FFI::MemoryPointer.new(self.size, 1)
          p  = FFI::Pointer.new(mp)
          this_self = new(p)
          this_self.send(:struct_initialize, *args)
          yield(this_self, *args) if block_given?
          this_self
        end

        #
        # +attr_reader+, +attr_writer+, +attr_accessor+
        # +attr_char_reader, +attr_char_writer+, +attr_char_accessor+
        #
        # Two basic sets of read/write methods are created, because we have to
        # differentiate whether we want to be able to convert to/from a single
        # +char+ (which +ruby+ will treat as a String object +C+ treats
        # differently)
        #
        def attr_reader(*m)
          method = 'read'
          m.flatten.each { |a| common_read_eval(a, method) }
        end

        def attr_writer(*m)
          method = 'write'
          m.flatten.each { |a| common_write_eval(a, method) }
        end

        def attr_accessor(*m)
          attr_reader(*m)
          attr_writer(*m)
        end

        def attr_char_reader(*m)
          method = 'read_char'
          m.flatten.each { |a| common_read_eval(a, method) }
        end

        def attr_char_writer(*m)
          method = 'write_char'
          m.flatten.each { |a| common_write_eval(a, method) }
        end

        def attr_char_accessor(*m)
          attr_char_reader(*m)
          attr_char_writer(*m)
        end

      private

        def common_read_eval(m, method)
          rms = "def #{m}(); #{method}_attribute(:#{m}); end"
          class_eval(rms) if exists_in_layout?(m)
        end

        def common_write_eval(m, method)
          wms = "def #{m}=(val); #{method}_attribute(:#{m}, val); end"
          class_eval(wms) if exists_in_layout?(m)
        end

        def exists_in_layout?(m)
          raise NoLayout, "No layout for class #{self.name}" unless self.layout
          raise NotALayoutMember, "method #{m} is not a layout member in class #{self.name}" unless self.layout.members.include?(m)
          true
        end

      end

      def read_attribute(attr)
        self[attr]
      end

      #
      # <tt>write_attribute(attr, val)</tt>
      #
      # writes +val+ into property +attr+. Care is taken to manage strings
      # properly, even tough there seems to be a general suggestion that
      # assigning strings is a Bad Thing (tm)
      #
      def write_attribute(attr, val)
        if self.class.layout[attr].type == FFI::Type::Builtin::STRING
          pos = offset_of(attr)
          sp = val.nil? ? FFI::MemoryPointer::NULL : FFI::MemoryPointer.from_string(val)
          self.pointer.put_pointer(pos, sp)
        else
          self[attr] = val
        end
        self[attr]
      end

      def read_char_attribute(attr)
        self[attr].chr
      end

      def write_char_attribute(attr, val)
        self[attr] = val.each_byte.map { |b| b }.first.to_i
        read_char_attribute(attr)
      end

    private

      #
      # <tt>struct_initialize(*args)</tt>
      #
      # the +struct_initialize+ private method can be overridden by 
      # subclasses just like the +initialize+ method can, and it will be
      # called by the <tt>create(*args)</tt> method just +new+ calls
      # the +initialize+ method.
      #
      # *PLEASE NOTE*: the +initialize+ method cannot be used as usual,
      # (just like +new+ cannot be used) because <tt>new()</tt> is used
      # by FFI to memory initialization - so don't use it unless you
      # *really* know what you are doing.
      #
      # The classes using this mixin should make this method +private+,
      # just as +initialize+ is.
      # 
      def struct_initialize(*args)
        #
        # this is supposed to be overridden and as such it is empty
        #
      end

    end

  end

end

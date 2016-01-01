require 'spec_helper'

describe 'FFI::Utilities::Struct' do

  before :example do
    @arg_1 = 0
    @arg_2 = 23.2323
    @arg_3 = 'T'
    @c_arg_1 = 1
    @c_arg_2 = 16.1616
    @c_arg_3 = 'C'
    @test_string = 'Test String'
  end

  context 'read-only methods' do

    module FFI::Utilities::Test

      extend FFI::Library

      class Struct0 < FFI::Utilities::Struct
        layout :var_1, :int, :var_2, :double, :var_3, :char

        attr_reader :var_1, :var_2
        attr_char_reader :var_3

        def struct_initialize(a = nil, b = nil, c = '')
          write_attribute(:var_1, a.to_i)
          write_attribute(:var_2, b.to_f)
          write_char_attribute(:var_3, c)
        end

      end

      attach_function :unmanaged_struct_copy, [Struct0.by_ref, :pointer], :void

    end

    it 'should respond only to read-only accessors' do
      expect((src = FFI::Utilities::Test::Struct0.create(@arg_1, @arg_2, @arg_3)).class).to be(FFI::Utilities::Test::Struct0)
      src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(true) }
      src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(false) }
    end

    it 'should read the proper values' do
      expect((src = FFI::Utilities::Test::Struct0.create(@arg_1, @arg_2, @arg_3)).class).to be(FFI::Utilities::Test::Struct0)
      1.upto(3) do
        |n|
        val = nil
        eval("val = @arg_#{n}")
        meth = :"var_#{n}"
        expect(src.send(meth)).to eq(val)
      end
    end

  end

  context 'write-only methods' do

    module FFI::Utilities::Test

      extend FFI::Library

      class Struct1 < FFI::Utilities::Struct
        layout :var_1, :int, :var_2, :double, :var_3, :char

        def struct_initialize(a = nil, b = nil, c = '')
          write_attribute(:var_1, a.to_i)
          write_attribute(:var_2, b.to_f)
          write_char_attribute(:var_3, c)
        end

        attr_writer :var_1, :var_2
        attr_char_writer :var_3

      end

      attach_function :unmanaged_struct_copy, [Struct1.by_ref, :pointer], :void

    end

    it 'should respond only to write-only accessors' do
      expect((src = FFI::Utilities::Test::Struct1.create).class).to be(FFI::Utilities::Test::Struct1)
      src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(false) }
      src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(true) }
    end

    it 'should write the proper values' do
      expect((src = FFI::Utilities::Test::Struct1.create).class).to be(FFI::Utilities::Test::Struct1)
      1.upto(3) do
        |n|
        val = nil
        eval("val = @arg_#{n}")
        meth = :"var_#{n}="
        rfield = "var_#{n}".to_sym
        expect(src.send(meth, val)).to eq(val)
        if n < 3
          expect(src[rfield]).to eq(val)
        else
          expect(src[rfield].chr).to eq(val)
        end
      end
    end

  end

  context 'read/write methods' do

    module FFI::Utilities::Test

      extend FFI::Library

      class Struct2 < FFI::Utilities::Struct
        layout :var_1, :int, :var_2, :double, :var_3, :char

        def struct_initialize(a = nil, b = nil, c = nil)
          write_attribute(:var_1, a.to_i)
          write_attribute(:var_2, b.to_f)
          write_char_attribute(:var_3, c)
        end

        attr_accessor :var_1, :var_2
        attr_char_accessor :var_3

      end

      attach_function :unmanaged_struct_copy, [Struct2.by_ref, :pointer], :void

    end

    it 'should respond to both read/write accessors' do
      expect((src = FFI::Utilities::Test::Struct2.create(@arg_1, @arg_2, @arg_3)).class).to be(FFI::Utilities::Test::Struct2)
      src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(true) }
      src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(true) }
    end

    it 'should read/write the proper values' do
      expect((src = FFI::Utilities::Test::Struct2.create(@arg_1, @arg_2, @arg_3)).class).to be(FFI::Utilities::Test::Struct2)
      1.upto(3) do
        |n|
        val = cval = nil
        eval("val = @arg_#{n}")
        eval("cval = @c_arg_#{n}")
        rmeth = :"var_#{n}"
        wmeth = :"var_#{n}="
        expect(src.send(rmeth)).to eq(val)
        expect(src.send(wmeth, cval)).to eq(cval)
        expect(src.send(rmeth)).to eq(cval)
      end
    end

  end

  context 'mixed methods' do

    module FFI::Utilities::Test

      extend FFI::Library

      class Struct22 < FFI::Utilities::Struct
        layout :var_1, :int, :var_2, :double, :var_3, :char

        def struct_initialize(a = nil, b = nil, c = nil)
          write_attribute(:var_1, a.to_i)
          write_attribute(:var_2, b.to_f)
          write_char_attribute(:var_3, c)
        end

        attr_reader :var_1
        attr_writer :var_2
        attr_char_accessor :var_3

      end

      attach_function :unmanaged_struct_copy, [Struct22.by_ref, :pointer], :void

    end

    it 'should respond in mixed ways' do
      expect((src = FFI::Utilities::Test::Struct22.create(0, 23.2323, 'T')).class).to be(FFI::Utilities::Test::Struct22)
      expect(src.respond_to?(:var_1)).to eq(true)
      expect(src.respond_to?(:var_1=)).to eq(false)
      expect(src.respond_to?(:var_2)).to eq(false)
      expect(src.respond_to?(:var_2=)).to eq(true)
      expect(src.respond_to?(:var_3)).to eq(true)
      expect(src.respond_to?(:var_3=)).to eq(true)
    end

    it 'should read/write the proper values' do
      expect((src = FFI::Utilities::Test::Struct22.create(@arg_1, @arg_2, @arg_3)).class).to be(FFI::Utilities::Test::Struct22)
      expect(src.var_1).to eq(@arg_1)
      expect(src.var_2 = @c_arg_2).to eq(@c_arg_2)
      expect(src.var_3).to eq(@arg_3)
      expect(src.var_3 = @c_arg_3).to eq(@c_arg_3)
      expect(src.var_3).to eq(@c_arg_3)
    end

  end

end

describe 'FFI::Utilities::UnmanagedStruct' do

  before :example do
    @arg_1 = 0
    @arg_2 = 23.2323
    @arg_3 = 'T'
    @c_arg_1 = 1
    @c_arg_2 = 16.1616
    @c_arg_3 = 'C'
    @test_string = 'Test String'
  end

  context 'read-only methods' do

    module FFI::Utilities::Test

      extend FFI::Library

      class Struct3 < FFI::Utilities::ManagedStruct
        layout :var_1, :int, :var_2, :double, :var_3, :string

        private_class_method :new

        @@released = false

        class << self

          def create(a = nil, b = nil, c = '')
            super(a, b, c) { |this, a, b, c| FFI::Utilities::Test.managed_struct_initialize(this, a, b, c) }
          end

          def released?
            @@released
          end

          def release(ptr)
            @@released = false
            FFI::Utilities::Test.managed_struct_free(ptr)
            @@released = true
          end

        end

        attr_reader layout.members

      end

      attach_function :managed_struct_initialize, [ Struct3.by_ref, :int, :double, :string ], :void
      attach_function :managed_struct_free,       [ Struct3.by_ref ], :void

    end

    it 'should respond only to read-only accessors' do
      expect((src = FFI::Utilities::Test::Struct3.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct3)
      src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(true) }
      src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(false) }
    end

    it 'should return the proper values' do
      expect((src = FFI::Utilities::Test::Struct3.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct3)
      expect(src.var_1).to eq(@arg_1)
      expect(src.var_2).to eq(@arg_2)
      expect(src.var_3).to eq(@test_string)
    end

    #
    # apparently not even the FFI maintainers are able to test reliably the
    # garbage collection of objects in MRI ruby, and they have disabled their
    # own tests (cf. [Issue #427](https://github.com/ffi/ffi/issues/427)
    #
    # So we disable ours too :-(
    #
    it 'should clean up after itself', :broken => true do
      count = GC.count # pick up the current GC count
      id = nil
      begin
        expect((src = FFI::Utilities::Test::Struct3.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct3)
        id = src.object_id
        src = nil
      end # object src goes out of scope so it can get be GC'ed
      GC.start # but we make sure we garbage collect
      expect(GC.count).to eq(count+1) # make sure we've garbage collected
      #
      # and the memory has been effectively released
      #
      expect { ObjectSpace._id2ref(id) }.to raise_error(RangeError) # RangeErrors happen when we deal with recycled objects
      #
      # FIXME: apparently +Struct3.release()+ does never get called :-(
      # And I do not know how to make sure that it is actually freed and
      # called.
      #
      expect(FFI::Utilities::Test::Struct3.released?).to be(true)
    end

  end

  context 'write-only methods' do

    module FFI::Utilities::Test

      extend FFI::Library

	    class Struct4 < FFI::Utilities::ManagedStruct
	      layout :var_1, :int, :var_2, :double, :var_3, :string
	
	      def struct_initialize(a = nil, b = nil, c = '')
          write_attribute(:var_1, a)
          write_attribute(:var_2, b)
          write_attribute(:var_3, c)
	      end
	
	      attr_writer layout.members
	
	      class << self
	
	        def release(ptr)
            FFI::Utilities::Test.managed_struct_free(ptr)
	        end
	
	      end
	
	    end

      attach_function :managed_struct_free,       [ Struct4.by_ref ], :void

    end

    it 'should respond only to write-only accessors' do
      expect((src = FFI::Utilities::Test::Struct4.create(@arg_1, @arg_2, @arg_3)).class).to be(FFI::Utilities::Test::Struct4)
      src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(false) }
      src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(true) }
    end

    it 'should write and return the proper values' do
      expect((src = FFI::Utilities::Test::Struct4.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct4)
      expect(src.var_1 = @arg_1 + 1).to eq(@arg_1 + 1)
      expect(src.var_2 = @arg_2 + 1).to eq(@arg_2 + 1)
      expect(src.var_3 = @test_string + ' ' + @test_string).to eq(@test_string + ' ' + @test_string)
    end

    it 'should accept also null string pointers' do
      expect((src = FFI::Utilities::Test::Struct4.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct4)
      expect(src.var_3 = nil).to eq(nil)
    end

  end

  context 'read/write methods' do

    module FFI::Utilities::Test

      extend FFI::Library

      class Struct5 < FFI::Utilities::ManagedStruct
        layout :var_1, :int, :var_2, :double, :var_3, :string
  
        def struct_initialize(a = nil, b = nil, c = '')
          write_attribute(:var_1, a)
          write_attribute(:var_2, b)
          write_attribute(:var_3, c)
        end
  
        attr_accessor layout.members

	      class << self
	
	        def release(ptr)
            FFI::Utilities::Test.managed_struct_free(ptr)
	        end
	
	      end
	
      end

      attach_function :managed_struct_free,       [ Struct5.by_ref ], :void

    end

    it 'should respond to both read/write accessors' do
      expect((src = FFI::Utilities::Test::Struct5.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct5)
      src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(true) }
      src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(true) }
    end

    it 'should return the proper values' do
      expect((src = FFI::Utilities::Test::Struct5.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct5)
      expect(src.var_1).to eq(@arg_1)
      expect(src.var_2).to eq(@arg_2)
      expect(src.var_3).to eq(@test_string)
    end

    it 'should write and return the proper values' do
      narg_1, narg_2, narg_3 = @arg_1 + 1, @arg_2 + 1, [@test_string, @test_string].join(' ')
      expect((src = FFI::Utilities::Test::Struct5.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct5)
      expect(src.var_1 = narg_1).to eq(narg_1)
      expect(src.var_2 = narg_2).to eq(narg_2)
      expect(src.var_3 = narg_3).to eq(narg_3)
      #
      # let's read them one more time
      #
      expect(src.var_1).to eq(narg_1)
      expect(src.var_2).to eq(narg_2)
      expect(src.var_3).to eq(narg_3)
    end
  end

  context 'mixed methods' do

    module FFI::Utilities::Test

      extend FFI::Library

	    class Struct52 < FFI::Utilities::ManagedStruct
	      layout :var_1, :int, :var_2, :double, :var_3, :string
	
	      def struct_initialize(a = nil, b = nil, c = '')
          write_attribute(:var_1, a)
          write_attribute(:var_2, b)
          write_attribute(:var_3, c)
	      end
	
	      attr_reader :var_1
	      attr_writer :var_2
	      attr_accessor :var_3
	
        class << self

		      def release(ptr)
            FFI::Utilities::Test.managed_struct_free(ptr)
		      end

        end
	
	    end

      attach_function :managed_struct_free,       [ Struct52.by_ref ], :void

    end

    it 'should respond in mixed ways' do
      expect((src = FFI::Utilities::Test::Struct52.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct52)
      expect(src.respond_to?(:var_1)).to eq(true)
      expect(src.respond_to?(:var_1=)).to eq(false)
      expect(src.respond_to?(:var_2)).to eq(false)
      expect(src.respond_to?(:var_2=)).to eq(true)
      expect(src.respond_to?(:var_3)).to eq(true)
      expect(src.respond_to?(:var_3=)).to eq(true)
    end

    it 'should do the right things with accessors' do
      narg_1, narg_2, narg_3 = @arg_1 + 1, @arg_2 + 1, [@test_string, @test_string].join(' ')
      expect((src = FFI::Utilities::Test::Struct52.create(@arg_1, @arg_2, @test_string)).class).to be(FFI::Utilities::Test::Struct52)
      expect(src.var_1).to eq(@arg_1)
      expect{ src.var_2 }.to raise_error(NoMethodError)
      expect(src.var_3).to eq(@test_string)
      #
      expect{ src.var_1 = narg_1 }.to raise_error(NoMethodError)
      expect(src.var_2 = narg_2).to eq(narg_2)
      expect(src.var_3 = narg_3).to eq(narg_3)
    end

  end

end

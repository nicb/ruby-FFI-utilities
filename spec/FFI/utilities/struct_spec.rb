require 'spec_helper'

describe 'FFI::Utilities::Struct' do

  context 'unmanaged struct' do

    context 'read-only methods' do

      module FFI::Utilities::Test

        extend FFI::Library

        class Struct0 < FFI::Utilities::Struct
          layout :var_1, :int, :var_2, :double, :var_3, :char
  
          def initialize(a = nil, b = nil, c = nil)
            @var_1, @var_2, @var_3 = a, b, c
          end
  
          sattr_reader layout.members
  
        end

        attach_function :unmanaged_struct_test, [Struct0.by_ref, :pointer], :void

      end

      it 'should respond only to read-only accessors' do
        expect((src = FFI::Utilities::Test::Struct0.new(0, 23.2323, 'T')).class).to be(FFI::Utilities::Test::Struct0)
        src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(true) }
        src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(false) }
      end

    end

    context 'write-only methods' do

      module FFI::Utilities::Test

        extend FFI::Library

        class Struct1 < FFI::Utilities::Struct
          layout :var_1, :int, :var_2, :double, :var_3, :char
  
          def initialize(a = nil, b = nil, c = nil)
            @var_1, @var_2, @var_3 = a, b, c
          end
  
          sattr_writer layout.members
  
        end

        attach_function :unmanaged_struct_test, [Struct1.by_ref, :pointer], :void

      end

      it 'should respond only to write-only accessors' do
        expect((src = FFI::Utilities::Test::Struct1.new(0, 23.2323, 'T')).class).to be(FFI::Utilities::Test::Struct1)
        src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(false) }
        src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(true) }
      end

    end

    context 'read/write methods' do

      module FFI::Utilities::Test

        extend FFI::Library

        class Struct2 < FFI::Utilities::Struct
          layout :var_1, :int, :var_2, :double, :var_3, :char
  
          def initialize(a = nil, b = nil, c = nil)
            @var_1, @var_2, @var_3 = a, b, c
          end
  
          sattr_accessor layout.members
  
        end

        attach_function :unmanaged_struct_test, [Struct2.by_ref, :pointer], :void

      end

      it 'should respond to both read/write accessors' do
        expect((src = FFI::Utilities::Test::Struct2.new(0, 23.2323, 'T')).class).to be(FFI::Utilities::Test::Struct2)
        src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(true) }
        src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(true) }
      end

    end

    context 'mixed methods' do

      module FFI::Utilities::Test

        extend FFI::Library

        class Struct22 < FFI::Utilities::Struct
          layout :var_1, :int, :var_2, :double, :var_3, :char
  
          def initialize(a = nil, b = nil, c = nil)
            @var_1, @var_2, @var_3 = a, b, c
          end
  
          sattr_reader :var_1
          sattr_writer :var_2
          sattr_accessor :var_3
  
        end

        attach_function :unmanaged_struct_test, [Struct22.by_ref, :pointer], :void

      end

      it 'should respond in mixed ways' do
        expect((src = FFI::Utilities::Test::Struct22.new(0, 23.2323, 'T')).class).to be(FFI::Utilities::Test::Struct22)
        expect(src.respond_to?(:var_1)).to eq(true)
        expect(src.respond_to?(:var_1=)).to eq(false)
        expect(src.respond_to?(:var_2)).to eq(false)
        expect(src.respond_to?(:var_2=)).to eq(true)
        expect(src.respond_to?(:var_3)).to eq(true)
        expect(src.respond_to?(:var_3=)).to eq(true)
      end

    end

  end

  context 'managed struct' do

    context 'read-only methods' do

      class TestStruct3 < FFI::Utilities::ManagedStruct
        layout :var_1, :int, :var_2, :double, :var_3, :string

        def initialize(a = nil, b = nil)
          @var_1, @var_2 = a, b
          @var_3 = FFI::MemoryPointer.from_string('Test String') # allocated dynamically
        end

        sattr_reader layout.members

        def release
          # what should we do here?
        end

      end

      it 'should respond only to read-only accessors' do
        expect((src = TestStruct3.new(0, 23.2323)).class).to be(TestStruct3)
        src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(true) }
        src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(false) }
      end

    end

    context 'write-only methods' do

      class TestStruct4 < FFI::Utilities::Struct
        layout :var_1, :int, :var_2, :double, :var_3, :string

        def initialize(a = nil, b = nil)
          @var_1, @var_2 = a, b
          @var_3 = FFI::MemoryPointer.from_string('Test String') # allocated dynamically
        end

        sattr_writer layout.members

        def release
          # what should we do here?
        end

      end

      it 'should respond only to write-only accessors' do
        expect((src = TestStruct4.new(0, 23.2323)).class).to be(TestStruct4)
        src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(false) }
        src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(true) }
      end

    end

    context 'read/write methods' do

      class TestStruct5 < FFI::Utilities::Struct
        layout :var_1, :int, :var_2, :double, :var_3, :string

        def initialize(a = nil, b = nil)
          @var_1, @var_2 = a, b
          @var_3 = FFI::MemoryPointer.from_string('Test String') # allocated dynamically
        end

        sattr_accessor layout.members

        def release
          # what should we do here?
        end

      end

      it 'should respond to both read/write accessors' do
        expect((src = TestStruct5.new(0, 23.2323)).class).to be(TestStruct5)
        src.class.layout.members.each { |m| expect(src.respond_to?(m)).to eq(true) }
        src.class.layout.members.each { |m| expect(src.respond_to?((m.to_s + '=').to_sym)).to eq(true) }
      end

    end

    context 'mixed methods' do

      class TestStruct52 < FFI::Utilities::Struct
        layout :var_1, :int, :var_2, :double, :var_3, :string

        def initialize(a = nil, b = nil)
          @var_1, @var_2 = a, b
          @var_3 = FFI::MemoryPointer.from_string('Test String') # allocated dynamically
        end

        sattr_reader :var_1
        sattr_writer :var_2
        sattr_accessor :var_3

        def release
          # what should we do here?
        end

      end

      it 'should respond in mixed ways' do
        expect((src = TestStruct52.new(0, 23.2323)).class).to be(TestStruct52)
        expect(src.respond_to?(:var_1)).to eq(true)
        expect(src.respond_to?(:var_1=)).to eq(false)
        expect(src.respond_to?(:var_2)).to eq(false)
        expect(src.respond_to?(:var_2=)).to eq(true)
        expect(src.respond_to?(:var_3)).to eq(true)
        expect(src.respond_to?(:var_3=)).to eq(true)
      end

    end

  end

end

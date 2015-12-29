module FFI
  module Utilities

    module Accessors

      class NoLayout < StandardError; end
      class NotALayoutMember < StandardError; end

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods

        def sattr_reader(*m)
          m.flatten.each { |a| attr_reader a if exists_in_layout?(a) }
        end

        def sattr_writer(*m)
          m.flatten.each { |a| attr_writer a if exists_in_layout?(a) }
        end

        def sattr_accessor(*m)
          m.flatten.each { |a| attr_accessor a if exists_in_layout?(a) }
        end

      private

        def exists_in_layout?(m)
          raise NoLayout, "No layout for class #{self.name}" unless self.layout
          raise NotALayoutMember, "method #{m} is not a layout member in class #{self.name}" unless self.layout.members.include?(m)
          true
        end

      end

    end

    class Struct < FFI::Struct

      include FFI::Utilities::Accessors

    end

    class ManagedStruct < FFI::ManagedStruct

      include FFI::Utilities::Accessors

    end

  end
end

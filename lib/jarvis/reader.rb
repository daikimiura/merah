# frozen_string_literal: true

require "jvm/class_file"
require "jvm/attribute"
require "jvm/method"
require "jvm/constant_pool/class"
require "jvm/constant_pool/fieldref"
require "jvm/constant_pool/methodref"
require "jvm/constant_pool/name_and_type"
require "jvm/constant_pool/string"
require "jvm/constant_pool/utf8"
require "jvm/attributes/code"
require "jvm/attributes/exception_table_item"
require "jvm/attributes/line_number_table"
require "jvm/attributes/line_number_table_item"
require "jvm/attributes/source_file"

require "pry-byebug"

module Jarvis
  class Reader
    class ConstantPoolTagNotSupported < StandardError
    end

    class AttributeNameNotSupported < StandardError
    end

    attr_accessor :file, :class_file

    def initialize(file_name:)
      @file = File.open(file_name, "rb:ASCII-8BIT")
      @class_file = ::Jvm::ClassFile.new
    end

    def read
      class_file.magic = file.read(4)
      class_file.minor_version = read_unsigned_short
      class_file.major_version = read_unsigned_short
      read_constant_pool
      class_file.access_flags = read_unsigned_short
      class_file.this_class = read_unsigned_short
      class_file.super_class = read_unsigned_short
      # In `Hello World` program, the values of `interfaces_count` and `fields_count` are 0,
      # so currently skip reading `interfaces` and `fields`
      class_file.interfaces_count = read_unsigned_short
      class_file.fields_count = read_unsigned_short
      read_methods

      class_file.attributes_count = read_unsigned_short
      class_file.attribute_info = []
      class_file.attributes_count.times do
        attribute = read_attribute
        class_file.attribute_info << attribute
      end

      class_file
    end

    private
      def read_unsigned_short
        file.read(2).unpack("n").first
      end

      def read_unsigned_long
        file.read(4).unpack("N").first
      end

      def read_constant_pool
        constant_pool_count = read_unsigned_short
        constant_pool_items = []

        (constant_pool_count - 1).times do
          tag = file.read(1).unpack("C").first
          case tag
          when 1
            length = read_unsigned_short
            bytes = []
            length.times { bytes << file.read(1) }

            constant_pool_items << ::Jvm::ConstantPool::Utf8.new(
              length: length,
              bytes: bytes
            )
          when 7
            name_index = read_unsigned_short
            constant_pool_items << ::Jvm::ConstantPool::Class.new(
              name_index: name_index
            )
          when 8
            string_index = read_unsigned_short
            constant_pool_items << ::Jvm::ConstantPool::String.new(
              string_index: string_index
            )
          when 9
            class_index = read_unsigned_short
            name_and_type_index = read_unsigned_short

            constant_pool_items << ::Jvm::ConstantPool::Fieldref.new(
              class_index: class_index,
              name_and_type_index: name_and_type_index
            )
          when 10
            class_index = read_unsigned_short
            name_and_type_inedx = read_unsigned_short

            constant_pool_items << ::Jvm::ConstantPool::Methodref.new(
              class_index: class_index,
              name_and_type_index: name_and_type_inedx
            )
          when 12
            name_index = read_unsigned_short
            descriptor_index = read_unsigned_short

            constant_pool_items << ::Jvm::ConstantPool::NameAndType.new(
              name_index: name_index,
              descriptor_index: descriptor_index
            )
          else
            raise ConstantPoolTagNotSupported, "tag: #{tag}"
          end
          class_file.constant_pool_count = constant_pool_count
          class_file.constant_pool_items = constant_pool_items
        end
      end

      def read_methods
        methods_count = read_unsigned_short
        methods = []
        methods_count.times do
          method = ::Jvm::Method.new
          method.access_flags = read_unsigned_short
          method.name_index = read_unsigned_short
          method.descriptor_index = read_unsigned_short
          method.attributes_count = read_unsigned_short
          method.attributes = []

          method.attributes_count.times do
            attribute = read_attribute
            method.attributes << attribute
          end

          methods << method
        end

        class_file.methods_count = methods_count
        class_file.methods = methods
      end

      def read_attribute
        attribute_name_index = read_unsigned_short
        attribute_length = read_unsigned_long

        attribute_name = class_file.constant_pool_items[attribute_name_index - 1].bytes.join
        case attribute_name
        when "Code"
          read_code_attribute(attribute_name_index, attribute_length)
        when "LineNumberTable"
          read_line_number_table_attribute(attribute_name_index, attribute_length)
        when "SourceFile"
          read_source_file_attribute(attribute_name_index, attribute_length)
        else
          raise AttributeNameNotSupported, "attribute_name: #{class_file.constant_pool_items[attribute_name_index - 1].bytes.join}"
        end
      end

      def read_code_attribute(attribute_name_index, attribute_length)
        max_stack = read_unsigned_short
        max_locals = read_unsigned_short

        code_length = read_unsigned_long
        code = []
        code_length.times { code << file.read(1).unpack("C").first }

        exception_table_length = read_unsigned_short
        exception_table = []
        exception_table_length.times do
          exception_table << ::Jvm::Attributes::ExceptionTableItem.new(
            start_pc: read_unsigned_short,
            end_pc: read_unsigned_short,
            handler_pc: read_unsigned_short,
            catch_type: read_unsigned_short,
          )
        end

        attributes_count = read_unsigned_short
        attributes = []
        attributes_count.times do
          attribute = read_attribute
          attributes << attribute
        end

        ::Jvm::Attributes::Code.new(
          attribute_name_index: attribute_name_index,
          attribute_length: attribute_length,
          max_stack: max_stack,
          max_locals: max_locals,
          code_length: code_length,
          code: code,
          exception_table_length: exception_table_length,
          exception_table: exception_table,
          attributes_count: attributes_count,
          attribute_info: attributes
        )
      end

      def read_line_number_table_attribute(attribute_name_index, attribute_length)
        line_number_table_length = read_unsigned_short
        line_number_table = []
        line_number_table_length.times do
          line_number_table << ::Jvm::Attributes::LineNumberTableItem.new(
            start_pc: read_unsigned_short,
            line_number: read_unsigned_short,
          )
        end

        ::Jvm::Attributes::LineNumberTable.new(
          attribute_name_index: attribute_name_index,
          attribute_length: attribute_length,
          line_number_table_length: line_number_table_length,
          line_number_table: line_number_table
        )
      end

      def read_source_file_attribute(attribute_name_index, attribute_length)
        sourcefile_index = read_unsigned_short
        ::Jvm::Attributes::SourceFile.new(
          attribute_name_index: attribute_name_index,
          attribute_length: attribute_length,
          sourcefile_index: sourcefile_index
        )
      end
  end
end

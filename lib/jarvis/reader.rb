# frozen_string_literal: true

require "jvm/class_file"
require "jvm/constant_pool/class"
require "jvm/constant_pool/fieldref"
require "jvm/constant_pool/methodref"
require "jvm/constant_pool/name_and_type"
require "jvm/constant_pool/string"
require "jvm/constant_pool/utf8"

require "pry-byebug"

module Jarvis
  class Reader
    class ConstantPoolTagNotSupported < StandardError
    end

    attr_accessor :file, :class_file

    def initialize(file_name:)
      @file = File.open(file_name, "rb:ASCII-8BIT")
      @class_file = ::Jvm::ClassFile.new
    end

    def read
      class_file.magic = file.read(4)
      class_file.minor_version = file.read(2).unpack("n").first
      class_file.major_version = file.read(2).unpack("n").first
      read_constant_pool
      class_file.access_flags = file.read(2).unpack("n").first
      class_file.this_class = file.read(2).unpack("n").first
      class_file.super_class = file.read(2).unpack("n").first
      class_file.interfaces_count = file.read(2).unpack("n").first
      binding.pry
    end

    private
      def read_constant_pool
        constant_pool_count = file.read(2).unpack("n").first
        constant_pool_items = []

        (constant_pool_count - 1).times do
          tag = file.read(1).unpack("C").first
          case tag
          when 1
            length = file.read(2).unpack("n").first
            bytes = []
            length.times { bytes << file.read(1) }

            constant_pool_items << ::Jvm::ConstantPool::Utf8.new(
              length: length,
              bytes: bytes
            )
          when 7
            name_index = file.read(2).unpack("n").first
            constant_pool_items << ::Jvm::ConstantPool::Class.new(
              name_index: name_index
            )
          when 8
            string_index = file.read(2).unpack("n").first
            constant_pool_items << ::Jvm::ConstantPool::String.new(
              string_index: string_index
            )
          when 9
            class_index = file.read(2).unpack("n").first
            name_and_type_index = file.read(2).unpack("n").first

            constant_pool_items << ::Jvm::ConstantPool::Fieldref.new(
              class_index: class_index,
              name_and_type_index: name_and_type_index
            )
          when 10
            class_index = file.read(2).unpack("n").first
            name_and_type_inedx = file.read(2).unpack("n").first

            constant_pool_items << ::Jvm::ConstantPool::Methodref.new(
              class_index: class_index,
              name_and_type_index: name_and_type_inedx
            )
          when 12
            name_index = file.read(2).unpack("n").first
            descriptor_index = file.read(2).unpack("n").first

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
  end
end

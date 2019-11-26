# frozen_string_literal: true

require "constant_pool/class"
require "constant_pool/methodref"
require "constant_pool/name_and_type"
require "constant_pool/string"
require "constant_pool/utf8"
require "pry"
require "pry-byebug"

module Jarvis
  class Reader
    attr_accessor :file

    def initialize(file_name:)
      @file = File.open(file_name, "rb:ASCII-8BIT")
    end

    def read
      file.seek(8, IO::SEEK_SET)
      read_constant_pool
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

            constant_pool_items << ::ConstantPool::Utf8.new(
              length: length,
              bytes: bytes
            )
          when 7
            name_index = file.read(2).unpack("n").first
            constant_pool_items << ::ConstantPool::Class.new(
              name_index: name_index
            )
          when 8
            string_index = file.read(2).unpack("n").first
            constant_pool_items << ::ConstantPool::String.new(
              string_index: string_index
            )
          when 10
            class_index = file.read(2).unpack("n").first
            name_and_type_inedx = file.read(2).unpack("n").first

            constant_pool_items << ::ConstantPool::Methodref.new(
              class_index: class_index,
              name_and_type_index: name_and_type_inedx
            )
          when 12
            name_index = file.read(2).unpack("n").first
            descriptor_index = file.read(2).unpack("n").first

            constant_pool_items << ::ConstantPool::NameAndType.new(
              name_index: name_index,
              descriptor_index: descriptor_index
            )
          end
        end
        binding.pry
      end
  end
end

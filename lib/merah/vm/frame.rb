# frozen_string_literal: true
require 'merah/vm/class_loader'
require 'merah/java/io/print_stream'
require 'merah/java/lang/system'
require 'merah/class_file/constant_pool/string'

module Merah
  module VM
    class Frame
      attr_accessor :instructions, :operand_stack, :local_variables, :constant_pool_items, :class_map

      MNEMONICS = {
        getstatic: 178,
        ldc: 18,
        invokevirtual: 182
      }

      def initialize(code_attribute:, constant_pool:)
        @instructions = StringIO.new(code_attribute.code, 'r')
        @operand_stack = []
        @local_variables = []
        @constant_pool_items = constant_pool
        @class_map = {}
      end

      def execute
        while (true)
          mnemonic = read_unsigned_char
          case mnemonic
          when MNEMONICS[:getstatic]
            operand = read_unsigned_short
            getstatic(operand)
          when MNEMONICS[:ldc]
            operand = read_unsigned_char
            ldc(operand)
          when MNEMONICS[:invokevirtual]
            operand = read_unsigned_short
            invokevirtual(operand)
          end
        end
      end

      private

        def read_unsigned_char
          instructions.read(1).unpack('C').first
        end

        def read_unsigned_short
          instructions.read(2).unpack('n').first
        end

        def constant_pool(index)
          constant_pool_items[index - 1]
        end

        def fetch_class(class_name)
          if class_map.has_key?(class_name)
            class_map(class_name)
          else
            initialize_class(class_name)
          end
        end

        def initialize_class(class_name)
          klass = ClassLoader.new.load_class(class_name)
          value = if /^java\//.match?(class_name)
                    klass.new
                  else
                    # TODO: Implement
                    raise 'User defined class called'
                  end

          class_map[class_name] = value
          value
        end

        def fetch_field_value(klass, field_name)
          if klass.is_a?(::Merah::ClassFile::ClassFile)
            # TODO: Implement
            raise 'User defined class called'
          else
            klass.send(field_name)
          end
        end

        def getstatic(operand)
          fieldref = constant_pool(operand)
          class_name_index = constant_pool(fieldref.class_index).name_index
          class_name = constant_pool(class_name_index).bytes.join
          klass = fetch_class(class_name)

          field_name_index = constant_pool(fieldref.name_and_type_index).name_index
          field_name = constant_pool(field_name_index).bytes.join

          operand_stack.push(fetch_field_value(klass, field_name))
        end

        def ldc(operand)
          constant_pool_item = constant_pool(operand)
          value = case constant_pool_item.tag
                  when 8 # ::Merah::ClassFile::ConstantPool::String
                    string_index = constant_pool_item.string_index
                    constant_pool(string_index).bytes.join
                  else
                    # TODO: Implement
                    raise "constant pool item type `#{constant_pool_item.class}` not supported"
                  end
          operand_stack.push(value)
        end

      def ivokevirtual
      end
    end
  end
end

# frozen_string_literal: true

require "merah/java/io/print_stream"
require "merah/java/lang/system"

module Merah
  module VM
    class Frame
      class MnemonicNotImplemented < StandardError
      end

      attr_accessor :vm, :instructions, :operand_stack, :local_variables, :constant_pool_items

      MNEMONICS = {
        getstatic: 178,
        ldc: 18,
        invokevirtual: 182,
        return: 177,
        iconst_m1: 2,
        iconst_0: 3,
        iconst_1: 4,
        iconst_2: 5,
        iconst_3: 6,
        iconst_4: 7,
        iconst_5: 8,
        istore_0: 59,
        istore_1: 60,
        istore_2: 61,
        istore_3: 62,
      }

      def initialize(vm:, code_attribute:, constant_pool:, local_variables:)
        @vm = vm
        @instructions = StringIO.new(code_attribute.code, "r")
        @operand_stack = []
        @local_variables = local_variables
        @constant_pool_items = constant_pool
      end

      def execute
        while true
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
          when MNEMONICS[:iconst_m1]
            operand_stack.push(-1)
          when MNEMONICS[:iconst_0]
            operand_stack.push(0)
          when MNEMONICS[:iconst_1]
            operand_stack.push(1)
          when MNEMONICS[:iconst_2]
            operand_stack.push(2)
          when MNEMONICS[:iconst_3]
            operand_stack.push(3)
          when MNEMONICS[:iconst_4]
            operand_stack.push(4)
          when MNEMONICS[:iconst_5]
            operand_stack.push(5)
          when MNEMONICS[:istore_0]
            variable = operand_stack.pop
            local_variables[0] = variable
          when MNEMONICS[:istore_1]
            variable = operand_stack.pop
            local_variables[1] = variable
          when MNEMONICS[:istore_2]
            variable = operand_stack.pop
            local_variables[2] = variable
          when MNEMONICS[:istore_3]
            variable = operand_stack.pop
            local_variables[3] = variable
          when MNEMONICS[:return]
            return
          else
            raise MnemonicNotImplemented, "mnemonic: #{mnemonic}"
          end
        end
      end

      private

        def read_unsigned_char
          instructions.read(1).unpack("C").first
        end

        def read_unsigned_short
          instructions.read(2).unpack("n").first
        end

        def constant_pool(index)
          constant_pool_items[index - 1]
        end

        def getstatic(operand)
          fieldref = constant_pool(operand)
          class_name_index = constant_pool(fieldref.class_index).name_index
          class_name = constant_pool(class_name_index).bytes.join
          klass = vm.fetch_class(class_name)

          field_name_index = constant_pool(fieldref.name_and_type_index).name_index
          field_name = constant_pool(field_name_index).bytes.join

          operand_stack.push(vm.fetch_field_value(klass, field_name))
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

        def invokevirtual(operand)
          methodref = constant_pool(operand)

          method_name_index = constant_pool(methodref.name_and_type_index).name_index
          method_name = constant_pool(method_name_index).bytes.join

          method_type_index = constant_pool(methodref.name_and_type_index).descriptor_index
          method_type = constant_pool(method_type_index).bytes.join

          arg_num = constant_pool(method_type_index).bytes.count { |i| i == ";" }
          method_args = []
          arg_num.times do
            method_args << operand_stack.pop
          end

          receiver = operand_stack.pop

          vm.call_instance_method(receiver, method_name, method_type, method_args)
        end
    end
  end
end

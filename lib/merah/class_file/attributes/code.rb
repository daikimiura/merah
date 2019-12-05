# frozen_string_literal: true

module Merah
  module ClassFile
    module Attributes
      class Code
        attr_reader :attribute_name_index, :attribute_length, :max_stack, :max_locals, :code_length, :code, :exception_table_length, :exception_table, :attributes_count, :attribute_info

        def initialize(attribute_name_index:, attribute_length:, max_stack:, max_locals:, code_length:, code:, exception_table_length:, exception_table:, attributes_count:, attribute_info:)
          @attribute_name_index = attribute_name_index
          @attribute_length = attribute_length
          @max_stack = max_stack
          @max_locals = max_locals
          @code_length = code_length
          @code = code
          @exception_table_length = exception_table_length
          @exception_table = exception_table
          @attributes_count = attributes_count
          @attribute_info = attribute_info
        end
      end
    end
  end
end

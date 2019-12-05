# frozen_string_literal: true

module Merah
  module ClassFile
    module Attributes
      class LineNumberTable
        attr_reader :attribute_name_index, :attribute_length, :line_number_table_length, :line_number_table

        def initialize(attribute_name_index:, attribute_length:, line_number_table_length:, line_number_table:)
          @attribute_name_index = attribute_name_index
          @attribute_length = attribute_length
          @line_number_table_length = line_number_table_length
          @line_number_table = line_number_table
        end
      end
    end
  end
end

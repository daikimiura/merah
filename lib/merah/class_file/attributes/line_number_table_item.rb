# frozen_string_literal: true

module Merah
  module ClassFile
    module Attributes
      class LineNumberTableItem
        attr_reader :start_pc, :line_number

        def initialize(start_pc:, line_number:)
          @start_pc = start_pc
          @line_number = line_number
        end
      end
    end
  end
end

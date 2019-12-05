# frozen_string_literal: true

module Merah
  module ClassFile
    module Attributes
      class ExceptionTableItem
        attr_reader :start_pc, :end_pc, :handler_pc, :catch_type

        def initialize(start_pc:, end_pc:, handler_pc:, catch_type:)
          @start_pc = start_pc
          @end_pc = end_pc
          @handler_pc = handler_pc
          @catch_type = catch_type
        end
      end
    end
  end
end

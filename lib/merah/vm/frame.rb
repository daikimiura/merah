# frozen_string_literal: true

module Merah
  module VM
    module Frame
      attr_accessor :instructions, :operand_stack, :local_variables

      def initialize(instructions:)
        @instructions = instructions
        @operand_stack = []
        @local_variables = []
      end
    end
  end
end

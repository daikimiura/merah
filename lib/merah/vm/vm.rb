# frozen_string_literal: true

module Merah
  module VM
    class VM
      attr_reader :class_file
      attr_accessor :operand_stack

      def initialize(class_file:)
        @class_file = class_file
        @operand_stack = []
      end

      # def run
      #   class_file.methos.
      # end
    end
  end
end

# frozen_string_literal: true

module Jarvis
  module Exec
    class VM
      attr_reader :class_file

      def initialize(class_file:)
        @class_file = class_file
      end

      def run
      end
    end
  end
end

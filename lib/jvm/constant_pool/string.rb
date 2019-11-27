# frozen_string_literal: true

module Jvm
  module ConstantPool
    class String
      TAG_VALUE = 8
      attr_reader :tag, :string_index

      def initialize(string_index:)
        @tag = TAG_VALUE
        @string_index = string_index
      end
    end
  end
end

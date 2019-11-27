# frozen_string_literal: true

module Jvm
  module ConstantPool
    class Class
      TAG_VALUE = 7
      attr_reader :tag, :name_index

      def initialize(name_index:)
        @tag = TAG_VALUE
        @name_index = name_index
      end
    end
  end
end

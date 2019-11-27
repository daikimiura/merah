# frozen_string_literal: true

module Jvm
  module ConstantPool
    class Methodref
      TAG_VALUE = 10
      attr_reader :tag, :class_index, :name_and_type_index

      def initialize(class_index:, name_and_type_index:)
        @tag = TAG_VALUE
        @class_index = class_index
        @name_and_type_index = name_and_type_index
      end
    end
  end
end

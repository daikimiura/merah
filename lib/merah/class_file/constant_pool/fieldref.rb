# frozen_string_literal: true

module Merah
  module ClassFile
    module ConstantPool
      class Fieldref
        TAG_VALUE = 9
        attr_reader :tag, :class_index, :name_and_type_index

        def initialize(class_index:, name_and_type_index:)
          @class_index = class_index
          @name_and_type_index = name_and_type_index
        end
      end
    end
  end
end

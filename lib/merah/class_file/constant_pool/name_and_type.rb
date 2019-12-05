# frozen_string_literal: true

module Merah
  module ClassFile
    module ConstantPool
      class NameAndType
        TAG_VALUE = 12
        attr_reader :tag, :name_index, :descriptor_index

        def initialize(name_index:, descriptor_index:)
          @name_index = name_index
          @descriptor_index = descriptor_index
        end
      end
    end
  end
end

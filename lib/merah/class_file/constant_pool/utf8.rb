# frozen_string_literal: true

module Merah
  module ClassFile
    module ConstantPool
      class Utf8
        TAG_VALUE = 1
        attr_reader :tag, :length, :bytes

        def initialize(length:, bytes:)
          @tag = TAG_VALUE
          @length = length
          @bytes = bytes
        end
      end
    end
  end
end

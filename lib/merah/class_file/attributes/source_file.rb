# frozen_string_literal: true

module Merah
  module ClassFile
    module Attributes
      class SourceFile
        attr_reader :attribute_name_index, :attribute_length, :sourcefile_index

        def initialize(attribute_name_index:, attribute_length:, sourcefile_index:)
          @attribute_name_index = attribute_name_index
          @attribute_length = attribute_length
          @sourcefile_index = sourcefile_index
        end
      end
    end
  end
end

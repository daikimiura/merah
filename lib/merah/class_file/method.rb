# frozen_string_literal: true

module Merah
  module ClassFile
    class Method
      attr_accessor :access_flags, :name_index, :descriptor_index, :attributes_count, :attributes
    end
  end
end

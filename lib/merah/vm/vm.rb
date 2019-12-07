# frozen_string_literal: true

require "merah/vm/frame"

module Merah
  module VM
    class VM
      class MethodNotFound < StandardError
      end

      class CodeNotFound < StandardError
      end

      attr_reader :class_file, :frame_stack

      def initialize(class_file:)
        @class_file = class_file
        @frame_stack = []
      end

      def execute
        method = search_method(name: "main", type: "([Ljava/lang/String;)V")
        code_attribute = search_code_attribute(method)

        Frame.new(
          code_attribute: code_attribute,
          constant_pool: class_file.constant_pool_items
        ).execute
      end

      private

        def constant_pool(index)
          class_file.constant_pool_items[index - 1]
        end


        def search_method(name:, type:)
          class_file.methods.each do |method|
            method_name = constant_pool(method.name_index).bytes.join
            method_type = constant_pool(method.descriptor_index).bytes.join
            return method if method_name == name && method_type == type
          end

          raise MethodNotFound, "name: #{name}, type: #{type}"
        end

        def search_code_attribute(method)
          method.attributes.each do |attribute|
            attribute_name = constant_pool(attribute.attribute_name_index).bytes.join
            return attribute if attribute_name == 'Code'
          end

          raise CodeNotFound, "attribute named 'Code' not found."
        end
    end
  end
end

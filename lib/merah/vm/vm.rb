# frozen_string_literal: true

require "merah/vm/frame"

module Merah
  module VM
    class VM
      class MethodNotFound < StandardError
      end

      attr_reader :class_file, :frame_stack

      def initialize(class_file:)
        @class_file = class_file
        @frame_stack = []
      end

      def execute
        binding.pry
        method = search_method(name: "main", type: "([Ljava/lang/String;)V")
        Frame.new()
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
    end
  end
end

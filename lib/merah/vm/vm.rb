# frozen_string_literal: true

require "merah/vm/frame"
require "merah/vm/class_loader"

module Merah
  module VM
    class VM
      class MethodNotFound < StandardError
      end

      class CodeNotFound < StandardError
      end

      attr_reader :entry_file_name, :frame_stack, :class_map
      attr_accessor :entry_class_file

      def initialize(entry_file_name:)
        @entry_file_name = entry_file_name
        @frame_stack = []
        @class_map = {}
      end

      def execute
        class_name = entry_file_name.gsub(".class", "")
        self.entry_class_file = fetch_class(class_name)

        method = search_method(class_name: class_name, method_name: "main", method_type: "([Ljava/lang/String;)V")
        code_attribute = search_code_attribute(method)

        Frame.new(
          vm: self,
          code_attribute: code_attribute,
          constant_pool: entry_class_file.constant_pool_items
        ).execute
      end


      def constant_pool(index)
        entry_class_file.constant_pool_items[index - 1]
      end


      def search_method(class_name:, method_name:, method_type:)
        class_map[class_name].methods.each do |method|
          name = constant_pool(method.name_index).bytes.join
          type = constant_pool(method.descriptor_index).bytes.join
          return method if method_name == name && method_type == type
        end

        raise MethodNotFound, "name: #{name}, type: #{type}"
      end

      def search_code_attribute(method)
        method.attributes.each do |attribute|
          attribute_name = constant_pool(attribute.attribute_name_index).bytes.join
          return attribute if attribute_name == "Code"
        end

        raise CodeNotFound, "attribute named 'Code' not found."
      end


      def fetch_class(class_name)
        if class_map.has_key?(class_name)
          class_map(class_name)
        else
          initialize_class(class_name)
        end
      end

      def initialize_class(class_name)
        klass = ClassLoader.new.load_class(class_name)
        value = if /^java\//.match?(class_name)
          klass.new
        else
          klass
        end

        class_map[class_name] = value
        value
      end

      def fetch_field_value(klass, field_name)
        if klass.is_a?(::Merah::ClassFile::ClassFile)
          # TODO: Implement
          raise "User defined class called"
        else
          klass.public_send(field_name)
        end
      end

      def call_instance_method(receiver, method_name, method_type, method_args)
        class_name = receiver.class_name
        # klass = fetch_class(class_name)
        if /^java\//.match?(class_name)
          receiver.public_send(method_name, *method_args)
        else
          # TODO: Implement (Create another frame and execute method)
        end
      end
    end
  end
end

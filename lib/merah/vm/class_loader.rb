# frozen_string_literal: true

require "merah/parser"
require "merah/java/io/print_stream"
require "merah/java/lang/system"

module Merah
  module VM
    class ClassLoader
      def load_class(class_name)
        if /^java\//.match?(class_name)
          rb_class_name = "::Merah::" + class_name.split("/").map(&:capitalize).join("::")
          eval(rb_class_name)
        else
          ::Merah::Parser.new(file_name: class_name + ".class").parse
        end
      end
    end
  end
end

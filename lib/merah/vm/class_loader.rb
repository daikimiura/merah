require 'merah/java/io/print_stream'
require 'merah/java/lang/system'

module Merah
  module VM
    class ClassLoader
      def load_class(class_name)
        if /^java\//.match?(class_name)
          rb_class_name = '::Merah::' + class_name.split('/').map(&:capitalize).join('::')
          eval(rb_class_name)
        else
          # TODO: Implement
          raise 'User defined class called'
        end
      end
    end
  end
end
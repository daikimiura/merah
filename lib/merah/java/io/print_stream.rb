# frozen_string_literal: true

require "merah/java/util"

module Merah
  module Java
    module IO
      class PrintStream
        include ::Merah::Java::Util

        def initialize
        end

        def println(arg)
          puts arg
        end
      end
    end
  end
end

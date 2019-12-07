# frozen_string_literal: true

require "merah/java/util"
require "merah/java/io/print_stream"

module Merah
  module Java
    module Lang
      class System
        include ::Merah::Java::Util

        attr_reader :out

        def initialize(out: nil)
          @out = ::Merah::Java::IO::PrintStream.new
        end
      end
    end
  end
end

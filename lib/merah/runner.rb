# frozen_string_literal: true

require "merah/parser"
require "merah/vm/vm"

module Merah
  class Runner
    def run(file_name)
      class_file = Parser.new(file_name: file_name).parse
      binding.pry
      # VM::VM.new(class_file).run
    end
  end
end

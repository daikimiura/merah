# frozen_string_literal: true

require "merah/parser"
require "merah/vm/vm"

module Merah
  class Runner
    def run(file_name)
      class_file = Parser.new(file_name: file_name).parse
      VM::VM.new(class_file: class_file).execute
    end
  end
end

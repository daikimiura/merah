# frozen_string_literal: true

require "jarvis/reader"

module Jarvis
  class Runner
    def run(file_name)
      class_file = Reader.new(file_name: file_name).read
      # Exec::VM.new(class_file).run
    end
  end
end

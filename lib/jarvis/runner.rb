# frozen_string_literal: true

require 'jarvis/reader'

module Jarvis
  class Runner
    def run(file_name)
      Reader.new(file_name: file_name).read
    end
  end
end
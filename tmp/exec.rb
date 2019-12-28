# frozen_string_literal: true

require "bundler/inline"
gemfile(true, quiet: true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  # Activate the gem you are reporting the issue against.
  gem "merah", path: "../"
end

require "merah"
java_class_file = "../test/HelloWorld.class"
::Merah::VM::VM.new(entry_file_name: java_class_file).execute

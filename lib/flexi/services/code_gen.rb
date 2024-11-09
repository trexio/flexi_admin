# frozen_string_literal: true

module Flexi::Services::CodeGen
  class << self
    def execute(prompt)
      Flexi::Services::CodeGen::Runner.new.execute(prompt)
    end
  end
end

require_relative "code_gen/runner"
require_relative "code_gen/code_export"
require_relative "code_gen/gpt"

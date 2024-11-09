# frozen_string_literal: true

module FlexiAdmin::Services::CodeGen
  class << self
    def execute(prompt)
      FlexiAdmin::Services::CodeGen::Runner.new.execute(prompt)
    end
  end
end

require_relative "code_gen/runner"
require_relative "code_gen/code_export"
require_relative "code_gen/gpt"

# frozen_string_literal: true

require_relative "jaaf/version"
require_relative "jaaf/config"
require_relative "jaaf/components/resources/resources_component"
require_relative "jaaf/controllers"

module Jaaf
  class Error < StandardError; end

  class << self
    def configure(&block)
      Jaaf::Config.configure(&block)
    end

    def configuration
      Jaaf::Config.configuration
    end
  end
end

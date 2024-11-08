# frozen_string_literal: true

# Gems
require "rails"
require "view_component"
require "slim-rails"

# Rails modules
require "action_view"
require "active_support"
require "active_support/core_ext"

# Version
require_relative "jaaf/version"

# Config
require_relative "jaaf/config"

# Core modules
require_relative "jaaf/controllers"
require_relative "jaaf/components"

# Helpers
require_relative "jaaf/helpers/jaaf_helpers"

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

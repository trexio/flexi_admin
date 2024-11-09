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
require_relative "flexi/version"

# Config
require_relative "flexi/config"

# Core modules
require_relative "flexi/controllers"
require_relative "flexi/components"
require_relative "flexi/services"

# Helpers
require_relative "flexi/helpers"

# Railtie
require 'flexi/railtie' if defined?(Rails)

module Flexi
  class Error < StandardError; end

  class << self
    def configure(&block)
      Flexi::Config.configure(&block)
    end

    def configuration
      Flexi::Config.configuration
    end
  end
end

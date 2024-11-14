# frozen_string_literal: true

# Gems
require "slim-rails"
require "view_component"
require "will_paginate"
require "will_paginate-bootstrap-style"

# Rails modules
require "action_view"
require "active_support"
require "active_support/core_ext"

# Version
require_relative "flexi_admin/version"

# Config
require_relative "flexi_admin/config"

# Helpers
require_relative "flexi_admin/helpers"

# Core modules
require_relative "flexi_admin/controllers"
require_relative "flexi_admin/components"
require_relative "flexi_admin/models"
require_relative "flexi_admin/services"
# Railtie
require "flexi_admin/railtie" if defined?(Rails)

# Routes
require "flexi_admin/routes"

module FlexiAdmin
  class Error < StandardError; end

  class << self
    def configure(&block)
      FlexiAdmin::Config.configure(&block)
    end

    def configuration
      FlexiAdmin::Config.configuration
    end
  end
end

# frozen_string_literal: true

module FlexiAdmin
  module Models
    module Concerns; end
    module Resources; end
  end
end

# Concerns
require_relative "models/concerns/parentable"
require_relative "models/concerns/application_resource"

# Resources
require_relative "models/resources/context"

require_relative "models/context_params"
require_relative "models/struct"
require_relative "models/toast"

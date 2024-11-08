# frozen_string_literal: true

module Jaaf
  module Components
    module Actions; end
    module Form; end
    module Helpers; end
    module Resources; end
    module Shared; end
  end
end

# Form Components
require_relative "components/form/field_component"
require_relative "components/form/label_component"
require_relative "components/form/rows_component"
require_relative "components/form/text_input_component"

# Action Components
require_relative "components/actions/checkbox_component"
require_relative "components/actions/select_component"

# Helpers
require_relative "components/helpers/action_button_helper"
require_relative "components/helpers/action_helper"
require_relative "components/helpers/icon_helper"
require_relative "components/helpers/link_helper"
require_relative "components/helpers/resource_helper"
require_relative "components/helpers/selectable"
require_relative "components/helpers/value_formatter"

# Shared Components
require_relative "components/shared/trix_component"
require_relative "components/shared/datalist_component"
require_relative "components/shared/medium_component"
require_relative "components/shared/table/header_item_component"
require_relative "components/shared/autocomplete/results_component"

# Resources Component
require_relative "components/resources/resources_component"

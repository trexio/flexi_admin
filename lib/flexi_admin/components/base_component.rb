# frozen_string_literal: true

module FlexiAdmin
  module Components
    class BaseComponent < ViewComponent::Base
      # Delegate main_app to view context
      delegate :main_app, to: :helpers
    end
  end
end

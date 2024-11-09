# frozen_string_literal: true

require "action_view"

module FlexiAdmin::Components::Helpers::UrlHelper
  include ::ActionView::Helpers::UrlHelper
  include ::ActionView::RoutingUrlFor
end

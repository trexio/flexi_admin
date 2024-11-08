# frozen_string_literal: true

module Jaaf::Components::Helpers::LinkHelper
  def navigate_to(title, resource)
    link_to title, resource, 'data-turbo-frame': "_top"
  end
end

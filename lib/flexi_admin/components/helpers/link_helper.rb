# frozen_string_literal: true

module FlexiAdmin::Components::Helpers::LinkHelper
  def navigate_to(title, resource)
    link_to title, resource, "data-turbo-frame": "_top"
  end
end

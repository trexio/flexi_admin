# frozen_string_literal: true

module FlexiAdmin::Components::Helpers::LinkHelper
  def navigate_to(title, resource)
    helpers.link_to title, resource, "data-turbo-frame": "_top"
    # content_tag(:a, title, href: resource, "data-turbo-frame": "_top")
  end
end

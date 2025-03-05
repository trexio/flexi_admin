# frozen_string_literal: true

module FlexiAdmin::Components::Helpers::LinkHelper
  def navigate_to(title, resource)
    path_segments = nil
    path_segments = if resource.is_a?(String)
                      resource
                    elsif FlexiAdmin::Config.configuration.namespace.present?
                      [FlexiAdmin::Config.configuration.namespace.to_sym, resource]
                    else
                      resource
                    end

    helpers.link_to title, path_segments, "data-turbo-frame": "_top"
  # content_tag(:a, title, href: resource, "data-turbo-frame": "_top")
  rescue StandardError => e
    binding.pry if Rails.env.development?
  end
end

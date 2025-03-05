# frozen_string_literal: true

require "action_view"

module FlexiAdmin::Components::Helpers::UrlHelper
  include ::ActionView::Helpers::UrlHelper
  include ::ActionView::RoutingUrlFor

  def namespaced_path(*segments)
    namespace = FlexiAdmin::Config.configuration.namespace

    segments.map! do |segment|
      segment = segment.to_s.gsub("/", "_")
      segment == "namespace" ? (namespace.presence || nil) : segment
    end
    segments.compact!
    "#{segments.join("_")}_path"
  end

  def route_exists_in_main_app?(path)
    main_app.respond_to?(path)
  end
end

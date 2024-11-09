# frozen_string_literal: true

module FlexiAdmin::Components::Resource
  class ViewComponent < ViewComponent::Base
    include FlexiAdmin::Components::Helpers::ResourceHelper
    include FlexiAdmin::Components::Helpers::ActionHelper

    attr_reader :context, :resource

    renders_one :form
    renders_one :actions

    def initialize(context)
      @context = context
      @resource = context.resource
    end

    def divider
      content_tag :div, "", class: "dropdown-divider"
    end
  end
end

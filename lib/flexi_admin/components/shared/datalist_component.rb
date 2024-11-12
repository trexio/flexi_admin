# frozen_string_literal: true

# Independent component.

module FlexiAdmin::Components::Shared
  class DatalistComponent < FlexiAdmin::Components::BaseComponent
    include FlexiAdmin::Components::Helpers::ResourceHelper

    attr_reader :resource, :disabled, :action, :parent

    def initialize(resource = nil, scope: nil, disabled: false, parent: nil)
      @resource = resource
      @scope = scope
      @parent = parent

      @action = action
      @disabled = disabled
    end
  end
end

# frozen_string_literal: true

# Independent component.

module Jaaf::Components::Shared
  class DatalistComponent < ViewComponent::Base
    include Jaaf::Components::Helpers::ResourceHelper

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

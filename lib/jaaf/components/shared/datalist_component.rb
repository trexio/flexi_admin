# frozen_string_literal: true

# Independent component.
class Shared::DatalistComponent < ViewComponent::Base
  include Helpers::ResourceHelper

  attr_reader :resource, :disabled, :action, :parent

  def initialize(resource = nil, scope: nil, disabled: false, parent: nil)
    @resource = resource
    @scope = scope
    @parent = parent

    @action = action
    @disabled = disabled
  end
end

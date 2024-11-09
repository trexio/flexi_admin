# frozen_string_literal: true

class Resource::FormComponent < ViewComponent::Base
  include Resource::FormMixin

  attr_reader :resource, :disabled

  def initialize(resource, disabled: true)
    @resource = resource
    @disabled = disabled
  end
end

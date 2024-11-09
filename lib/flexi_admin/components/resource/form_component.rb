# frozen_string_literal: true

module FlexiAdmin::Components::Resource
  class FormComponent < ViewComponent::Base
    include FlexiAdmin::Components::Resource::FormMixin

    attr_reader :resource, :disabled

    def initialize(resource, disabled: true)
      @resource = resource
      @disabled = disabled
    end
  end
end

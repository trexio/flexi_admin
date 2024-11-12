# frozen_string_literal: true

module FlexiAdmin::Components::Resource
  class FormComponent < FlexiAdmin::Components::BaseComponent
    include FlexiAdmin::Components::Resource::FormMixin

    attr_reader :resource, :disabled

    def initialize(resource, disabled: true)
      @resource = resource
      @disabled = disabled
    end
  end
end

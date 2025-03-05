# frozen_string_literal: true

module FlexiAdmin::Components::Resource
  class FormComponent < FlexiAdmin::Components::BaseComponent
    include FlexiAdmin::Components::Resource::FormMixin

    attr_reader :resource

    def initialize(resource, disabled: true)
      @resource = resource
      @disabled = disabled
    end

    def disabled
      if defined?(CanCan)
        !helpers.current_ability&.can?(:update, resource) || @disabled
      else
        @disabled
      end
    end
  end
end

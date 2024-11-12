# frozen_string_literal: true

module FlexiAdmin::Components::Shared
  class TrixComponent < FlexiAdmin::Components::BaseComponent
    attr_reader :form, :name, :options

    def initialize(form, name, options = {})
      @form = form
      @name = name
      @options = options
    end

    def input_classes
      "trix-content #{options[:class]}"
    end
  end
end

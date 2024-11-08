# frozen_string_literal: true

module Jaaf::Components::Shared
  class TrixComponent < ViewComponent::Base
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

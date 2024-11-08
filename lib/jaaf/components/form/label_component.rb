# frozen_string_literal: true

module Jaaf::Components::Form
  class LabelComponent < ViewComponent::Base
    attr_reader :form, :name, :options

    def initialize(form, name, options = {})
      @form = form
      @name = name
      @options = options
    end
  end
end

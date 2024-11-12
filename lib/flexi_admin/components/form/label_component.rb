# frozen_string_literal: true

module FlexiAdmin::Components::Form
  class LabelComponent < FlexiAdmin::Components::BaseComponent
    attr_reader :form, :name, :options

    def initialize(form, name, options = {})
      @form = form
      @name = name
      @options = options
    end
  end
end

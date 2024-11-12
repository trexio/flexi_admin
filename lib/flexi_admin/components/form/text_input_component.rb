# frozen_string_literal: true

module FlexiAdmin::Components::Form
  class TextInputComponent < FlexiAdmin::Components::BaseComponent
    attr_reader :form, :name, :options

    def initialize(form, name, options = {})
      @form = form
      @name = name
      @options = options
    end

    def input_classes
      "appearance-none inline-flex bg-gray-25 disabled:cursor-not-allowed text-gray-600 disabled:opacity-50 rounded py-2 px-3 leading-tight border focus:border-gray-600 focus-visible:ring-0 focus:text-gray-700 placeholder:text-gray-300 border-gray-200 w-full"
    end
  end
end

# frozen_string_literal: true

module FlexiAdmin::Components::Resources
  class ViewComponent < FlexiAdmin::Components::BaseComponent
    attr_reader :context, :title

    renders_one :actions
    renders_one :views

    def initialize(context)
      @context = context
      @title = context.options[:title]
    end
  end
end

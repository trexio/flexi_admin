# frozen_string_literal: true

# Independent component.

module FlexiAdmin::Components::Shared
  class LinkComponent < FlexiAdmin::Components::BaseComponent
    attr_reader :title, :path, :options

    def initialize(title, path, **options)
      @title = title
      @path = path
      @options = options
    end
  end
end

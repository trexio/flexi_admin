# frozen_string_literal: true

module FlexiAdmin::Components::Resource
  class LinkActionComponent < FlexiAdmin::Components::BaseComponent
    extend FlexiAdmin::Components::Helpers::ActionButtonHelper
    include FlexiAdmin::Components::Helpers::IconHelper

    attr_reader :label, :path, :options

    def initialize(label, path, **options)
      @label = label
      @path = path
      @options = options
    end
  end
end

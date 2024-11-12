# frozen_string_literal: true

module FlexiAdmin::Components::Resources::ListView
  class TableComponent < FlexiAdmin::Components::BaseComponent
    include FlexiAdmin::Components::Helpers::ResourceHelper

    attr_reader :columns, :headers, :resources, :selectable, :context

    def initialize(headers, columns, resources, context, selectable: false)
      @columns = columns
      @headers = headers
      @resources = resources
      @selectable = selectable
      @context = context
    end

    def selectable?
      @selectable
    end
  end
end

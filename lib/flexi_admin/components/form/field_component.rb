# frozen_string_literal: true

require "view_component"

module FlexiAdmin::Components::Form
  class FieldComponent < FlexiAdmin::Components::BaseComponent
    def call
      content_tag :div, content, class: "field-wrapper relative flex flex-col grow pb-2 md:pb-0 leading-tight min-h-14 h-full field-wrapper-layout-inline md:flex-row md:items-center field-wrapper-size-regular field-width-regular"
    end
  end
end

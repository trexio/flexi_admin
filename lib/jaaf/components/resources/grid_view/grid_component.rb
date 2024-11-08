# frozen_string_literal: true

class Resources::GridView::GridComponent < ViewComponent::Base
  attr_reader :resources, :title_element, :header_element, :description_element, :image_element, :context

  def initialize(resources, title_element, header_element, description_element, image_element, context)
    @resources = resources
    @title_element = title_element
    @header_element = header_element
    @description_element = description_element
    @image_element = image_element
    @context = context
  end
end

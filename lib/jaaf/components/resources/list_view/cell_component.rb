# frozen_string_literal: true

class Resources::ListView::CellComponent < ViewComponent::Base
  attr_reader :value, :width, :justify, :options

  def initialize(value, width: nil, **options)
    @value = value
    @width = width
    @options = options
    @justify = options[:justify]
  end

  def width_class
    width ? "col-#{width}" : 'col'
  end

  def justify_class
    justify ? "text-#{justify}" : ''
  end

  def merged_classes
    [width_class, justify_class].join(' ')
  end
end

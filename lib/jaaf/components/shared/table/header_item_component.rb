# frozen_string_literal: true

class Shared::Table::HeaderItemComponent < ViewComponent::Base
  attr_reader :column, :attr, :justify, :width

  def initialize(column)
    @column = column
    @justify = column.options[:justify] || :start
    @width = column.options[:width] || ''
    @attr = column.attribute
    @sort_by = column.sort_by
    @label = column.label
  end

  def label
    @label || attr.to_s.humanize
  end

  def sort_path
    return request.path if order.blank?

    request.path + "?sort=#{attr}&order=#{order}"
  end

  def merged_classes
    [width_class, justify_class].join(' ')
  end

  def width_class
    width.present? ? "col-#{width}" : 'col'
  end

  def justify_class
    case justify.to_sym
    when :start
      'justify-content-start'
    when :end
      'justify-content-end'
    else
      'justify-content-start'
    end
  end

  def sort_icon
    return 'bi-arrow-up-square' if params[:sort].to_s != attr.to_s

    case params[:order]
    when 'asc'
      'bi-arrow-up-square-fill'
    when 'desc'
      'bi-arrow-down-square-fill'
    else
      'bi-arrow-up-square'
    end
  end

  def order
    return 'asc' if params[:sort].to_s != attr.to_s

    case params[:order]
    when 'asc'
      'desc'
    when 'desc'
      nil
    when 'original'
      'asc'
    else
      'asc'
    end
  end
end

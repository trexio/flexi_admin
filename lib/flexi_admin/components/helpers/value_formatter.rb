# frozen_string_literal: true

module FlexiAdmin::Components::Helpers::ValueFormatter

  def as_text(value)
    value.to_s
  end

  def as_date(value, format: nil)
    return nil if value.blank?

    I18n.l(value, format:)
  end

  def as_navigation(value)
    helpers.link_to value, value, 'data-turbo-frame': '_top'
  end

  def format(formatter)
    case formatter.to_sym
    when :date
      proc { |value| as_date(value) }
    when :text
      proc { |value| as_text(value) }
    when :navigation
      proc { |value| as_navigation(value) }
    else
      raise ArgumentError, "Unknown formatter: #{@formatter}"
    end
  end
end

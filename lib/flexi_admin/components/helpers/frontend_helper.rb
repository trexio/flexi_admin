# frozen_string_literal: true

require "action_view"

module FlexiAdmin::Components::Helpers::FrontendHelper
  def active(path, predicate = :ends_with)
    css_match "active", request.path, match: path, use: predicate
  end

  # Example: css_match 'active', request.path, match: 'alternativy', use: :starts_with
  def css_match(klasses, subject, match:, use: :includes)
    case use
    when :starts_with
      klasses if subject.to_s.starts_with?(match)
    when :ends_with
      klasses if subject.to_s.ends_with?(match)
    when :includes
      klasses if subject.to_s.include?(match)
    else
      raise "Unknown predicate: #{predicate}"
    end
  end
end

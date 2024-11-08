# frozen_string_literal: true

class Actions::SelectComponent < ViewComponent::Base
  attr_reader :scope, :label

  renders_many :actions

  def initialize(context: nil, scope: nil, label: 'Akce')
    @context = context
    @scope = scope || context&.scope
    @label = label

    raise ArgumentError, 'context or scope is required' if context.blank? && scope.blank?
  end
end

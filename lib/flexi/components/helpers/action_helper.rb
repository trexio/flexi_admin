# frozen_string_literal: true

module Flexi::Components::Helpers::ActionHelper
  def action(action_component, disabled: true, selection_dependent: true)
    render Flexi::Components::Resources::BulkAction::ButtonComponent.new(context,
                                                                        action_component,
                                                                        disabled:,
                                                                        selection_dependent:)
  end
end

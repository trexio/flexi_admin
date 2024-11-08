# frozen_string_literal: true

module Jaaf::Components::Helpers::ActionHelper
  def action(action_component, disabled: true, selection_dependent: true)
    render Jaaf::Components::Resources::BulkAction::ButtonComponent.new(context,
                                                                        action_component,
                                                                        disabled:,
                                                                        selection_dependent:)
  end
end

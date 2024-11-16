# frozen_string_literal: true

module FlexiAdmin::Components::Helpers::ActionHelper
  def action(action_component, disabled: true, selection_dependent: true)
    render FlexiAdmin::Components::Resources::BulkAction::ButtonComponent.new(context,
                                                                              action_component,
                                                                              disabled:,
                                                                              selection_dependent:)
  end
end

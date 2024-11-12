# frozen_string_literal: true

module FlexiAdmin::Components::Shared
  class AlertComponent < FlexiAdmin::Components::BaseComponent
    attr_reader :message

    def initialize(message:)
      @message = message
    end
  end
end

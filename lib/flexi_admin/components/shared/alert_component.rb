# frozen_string_literal: true

module FlexiAdmin::Components::Shared
  class AlertComponent < ViewComponent::Base
    attr_reader :message

    def initialize(message:)
      @message = message
    end
  end
end

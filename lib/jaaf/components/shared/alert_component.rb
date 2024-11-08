# frozen_string_literal: true

module Jaaf::Components::Shared
  class AlertComponent < ViewComponent::Base
    attr_reader :message

    def initialize(message:)
      @message = message
    end
  end
end

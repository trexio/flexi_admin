# frozen_string_literal: true

module Flexi::Components::Shared
  class AlertComponent < ViewComponent::Base
    attr_reader :message

    def initialize(message:)
      @message = message
    end
  end
end

# frozen_string_literal: true

class Shared::AlertComponent < ViewComponent::Base
  attr_reader :message

  def initialize(message:)
    @message = message
  end
end

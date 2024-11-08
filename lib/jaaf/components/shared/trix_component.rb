# frozen_string_literal: true

class Shared::TrixComponent < ViewComponent::Base
  attr_reader :attr_name, :value, :disabled

  def initialize(attr_name:, value:, disabled: false)
    @attr_name = attr_name
    @value = value
    @disabled = disabled
  end

  def element_id
    "trix-input-#{@attr_name}" || SecureRandom.uuid
  end

  def short_text?
    value.present? && value.size < 150
  end
end

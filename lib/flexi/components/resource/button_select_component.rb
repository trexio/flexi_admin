# frozen_string_literal: true

# Requirement is handled by the model
class Resource::ButtonSelectComponent < ViewComponent::Base
  attr_reader :resource, :attr_name, :options, :form, :label, :value, :html_options, :disabled

  def initialize(resource, attr_name, options, form:, label: nil, value: nil, disabled: false, **html_options)
    @resource = resource
    @attr_name = attr_name
    @options = options
    @form = form
    @label = label
    @value = value
    @html_options = html_options
    @disabled = disabled
  end
end

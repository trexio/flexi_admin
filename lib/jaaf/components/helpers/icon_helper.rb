# frozen_string_literal: true

# Extend this module in the component to add class methods for registering a icon
module Helpers::IconHelper
  def icon
    self.class.instance_variable_get(:@icon_value) || options[:icon]
  end

  def icon_class
    "bi-#{icon}" if icon.present?
  end
end

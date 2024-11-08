# frozen_string_literal: true

# Extend this module in the component to add class methods for registering a button
module Helpers::ActionButtonHelper
  def button(label, icon: nil)
    @button = label
    @button_icon = icon
  end

  def button_text
    @button
  end

  def button_icon
    @button_icon
  end

  def button_icon_class
    "bi-#{button_icon}"
  end

  def title(title)
    @title = title
  end

  def title_text
    @title
  end
end

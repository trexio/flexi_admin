# frozen_string_literal: true

module Flexi::Components::Helpers::ActionButtonHelper
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

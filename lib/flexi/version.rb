# frozen_string_literal: true

module Flexi
  VERSION = "0.1.1"

  def self.version
    binding.pry if Rails.env.development?
    VERSION
  end
end

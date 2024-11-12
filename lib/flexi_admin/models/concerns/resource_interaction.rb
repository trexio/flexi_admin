# frozen_string_literal: true

module FlexiAdmin::Models::Concerns::ResourceInteraction
  class ResourceInteraction < ActiveInteraction::Base
    attr_accessor :resource
  end
end

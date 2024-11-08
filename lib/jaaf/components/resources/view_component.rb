# frozen_string_literal: true

class Resources::ViewComponent < ViewComponent::Base
  attr_reader :context, :title

  renders_one :actions
  renders_one :views

  def initialize(context)
    @context = context
    @title = context.options[:title]
  end
end

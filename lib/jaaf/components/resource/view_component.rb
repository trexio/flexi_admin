# frozen_string_literal: true

class Resource::ViewComponent < ViewComponent::Base
  include Helpers::ResourceHelper
  include Helpers::ActionHelper

  attr_reader :context, :resource

  renders_one :form
  renders_one :actions

  def initialize(context)
    @context = context
    @resource = context.resource
  end

  def divider
    content_tag :div, '', class: 'dropdown-divider'
  end
end

# frozen_string_literal: true

# Independent component.
class Resources::SwitchViewComponent < ViewComponent::Base
  include Helpers::ResourceHelper

  attr_reader :views, :context

  def initialize(context)
    @context = context
    @views = context.views.presence || %w[list]
  end

  def render?
    views.size > 1
  end

  def list_view_available?
    views.include?('list')
  end

  def grid_view_available?
    views.include?('grid')
  end

  def list_class
    if context.params.current_view == 'list' ||
       (context.views.first == 'list' && context.params.current_view.blank?)
      'active'
    else
      'bg-white text-dark'
    end
  end

  def grid_class
    if context.params.current_view == 'grid' ||
       (context.views.first == 'grid' && context.params.current_view.blank?)
      'active'
    else
      'bg-white text-dark'
    end
  end
end

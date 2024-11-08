# frozen_string_literal: true

class Resource::ShowPageComponent < ViewComponent::Base
  include Helpers::ResourceHelper
  include Helpers::ActionHelper
  attr_reader :resource, :context_params, :disabled

  def initialize(resource, context_params:, scope: nil, disabled: true)
    @resource = resource
    @scope = scope
    @context_params = context_params
    @disabled = disabled
  end

  def context
    @context ||= Resources::Context.from_params(context_params.merge(scope: @scope), resource)
  end
end

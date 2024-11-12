# frozen_string_literal: true

module FlexiAdmin::Components::Resources
  class ResourcesComponent < FlexiAdmin::Components::BaseComponent
    include FlexiAdmin::Components::Helpers::ActionHelper

    attr_reader :resources, :scope, :options, :title, :context_params

    renders_one :actions
    renders_one :views

    class << self
      attr_accessor :views, :scope, :includes
    end

    def initialize(resources, context_params:, views: nil, title: nil, **options)
      @resources = resources
      @scope = self.class.scope
      @options = options
      @options[:views] = views if views.present?
      @context_params = context_params
      @title = title
    end

    def context
      options = @options.merge(title:,
                               views: @options[:views].presence || self.class.views)

      context_params_with_parent = context_params.with_parent(options[:parent])

      @context ||= FlexiAdmin::Models::Resources::Context.new(resources, scope, context_params_with_parent, options)
    end
  end
end

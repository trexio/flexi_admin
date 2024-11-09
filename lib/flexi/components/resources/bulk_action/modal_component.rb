# frozen_string_literal: true

class Resources::BulkAction::ModalComponent < Resource::FormComponent
  include Resource::FormMixin
  extend Helpers::ActionButtonHelper

  attr_reader :context

  renders_one :modal_form

  def initialize(context = nil)
    @context = context

    add_context_options(@context)
    super(nil, disabled: false)
  end

  def modal(context, &block)
    render Resources::BulkAction::ModalComponent.new(context) do |component|
      component.with_modal_form(&block)
    end
  end

  def form(url: bulk_action_path(scope), method: :post, **html_options, &block)
    super(url:, css_class: 'modalForm section', method:, **html_options, &block)
  end

  # /observation_images/bulk_action
  def self.path
    resource = to_s.split('::').first.underscore.gsub('/', '-')
    "/#{resource.pluralize}/bulk_action"
  end

  def self.modal_id
    to_s.underscore.gsub('/', '-')
  end

  def add_context_options(context)
    # Means it's been already added by the parent component
    return if context.options[:title].present?

    context.options ||= {}
    context.options[:title] = self.class.title_text
    context.options[:modal_id] = self.class.modal_id
    context.options[:action_path] = self.class.path
  end
end

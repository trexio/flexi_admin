# frozen_string_literal: true

class Resource::FormElementComponent < ViewComponent::Base
  include Helpers::ResourceHelper

  renders_one :fields

  attr_reader :resource, :url, :css_class, :method, :html_options

  def initialize(resource, url:, css_class:, method: :post, **html_options)
    @resource = resource
    @url = url
    @css_class = css_class
    @method = method
    @html_options = html_options
  end

  def form_id
    resource.try(:identifier) || 'form'
  end
end

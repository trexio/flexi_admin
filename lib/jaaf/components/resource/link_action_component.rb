# frozen_string_literal: true

class Resource::LinkActionComponent < ViewComponent::Base
  extend Helpers::ActionButtonHelper
  include Helpers::IconHelper

  attr_reader :label, :path, :options

  def initialize(label, path, **options)
    @label = label
    @path = path
    @options = options
  end
end

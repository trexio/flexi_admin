# frozen_string_literal: true

class FlexiAdmin::Services::UpdateResource
  attr_reader :resource, :params, :errors

  def initialize(resource:, params:)
    @resource = resource
    @params = params
    @errors = {}
  end

  def self.run(resource:, params:)
    new(resource:, params:).run
  end

  def run
    if resource.update(params)
      resource
    else
      @errors.merge!(resource.errors)
      nil
    end

    self
  end

  def valid?
    resource.present? && resource.valid?
  end
end

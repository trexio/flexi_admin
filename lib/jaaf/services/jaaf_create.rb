# frozen_string_literal: true

class Generic::Services::Create < ResourceInteraction
  hash :params, strip: false
  object :resource_class, class: 'ActiveRecord::Base'

  def execute
    raise 'WIP: check implementation'

    resource = resource_class.create!(params)

    if resource.persisted?
      resource
    else
      # binding.pry if Rails.env.development?
      errors.merge!(resource.errors)
    end

    resource
  end
end

# frozen_string_literal: true

class Generic::Services::Update < ResourceInteraction
  object :resource, class: 'ActiveRecord::Base'
  hash :params, strip: false

  def execute
    if resource.update!(params)
      resource
    else
      errors.merge!(resource.errors)
    end
  end
end

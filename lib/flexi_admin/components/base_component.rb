# frozen_string_literal: true

module FlexiAdmin
  module Components
    class BaseComponent < ViewComponent::Base
      include FlexiAdmin::Helpers::ApplicationHelper

      # Delegate main_app to view context
      delegate :main_app, to: :helpers

      def render(*args)
        super(*args)
      rescue StandardError => e
        binding.pry if Rails.env.development? && !defined?(@@once)
        @@once = true
      end
    end
  end
end

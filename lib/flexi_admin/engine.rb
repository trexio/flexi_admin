# frozen_string_literal: true

module FlexiAdmin
  class Engine < ::Rails::Engine
    isolate_namespace FlexiAdmin

    initializer "flexi_admin.assets" do |app|
      app.config.assets.precompile += %w[flexi_admin_main.css]
    end

    initializer "flexi_admin.helpers" do
      ActiveSupport.on_load(:action_controller) do
        include FlexiAdmin::Helpers::ApplicationHelper
      end

      ActiveSupport.on_load(:view_component) do
        include Rails.application.routes.url_helpers
      end
    end

    config.to_prepare do
      Dir.glob(Engine.root.join("app", "**", "*_decorator*.rb")).each do |c|
        require_dependency(c)
      end
    end
  end
end

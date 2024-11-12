require "rails"
# require "flexi_admin/engine"

module FlexiAdmin
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/flexi_admin.rake"
    end

    initializer "flexi_admin.configure" do |app|
      # Add any additional configuration here
    end

    initializer "flexi_admin.assets" do |app|
      # Add asset paths to host application
      app.config.assets.paths << make_path("lib/flexi_admin/javascript")
      app.config.assets.paths << make_path("lib/flexi_admin/assets/stylesheets")

      # Add precompile assets
      app.config.assets.precompile += %w[flexi_admin.js]
    end

    # Configure importmap if using it
    initializer "flexi_admin.importmap", before: "importmap" do |app|
      app.config.importmap.paths << make_path("app/flexi_admin/javascript") if app.config.respond_to?(:importmap)
    end

    # Configure stimulus controllers if needed
    initializer "flexi_admin.stimulus_controllers" do |app|
      if app.config.respond_to?(:stimulus_modules)
        app.config.stimulus_modules |= [
          { name: "flexi-admin", path: "flexi_admin/controllers" }
        ]
      end
    end

    def make_path(path)
      [Gem::Specification.find_by_name("flexi_admin").gem_dir, path].join("/")
    end
  end
end

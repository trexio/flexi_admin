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
  end
end

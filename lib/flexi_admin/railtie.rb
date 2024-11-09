module FlexiAdmin
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/flexi_admin.rake"
    end
  end
end

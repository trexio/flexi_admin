module Flexi
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/flexi.rake"
    end
  end
end

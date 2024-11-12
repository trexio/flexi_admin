# frozen_string_literal: true

class Observation::ResourcesComponent < FlexiAdmin::Components::Resources::ResourcesComponent
  self.scope = "observations"
  self.views = %w[grid list]
  self.includes = %w[inspected_element]
end

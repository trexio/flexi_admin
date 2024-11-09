# frozen_string_literal: true

class Observation::Show::PageComponent < Resource::ShowPageComponent
  def observation_images
    paginate(resource.images)
  end
end

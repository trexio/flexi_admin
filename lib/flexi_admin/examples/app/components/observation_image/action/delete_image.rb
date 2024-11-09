# frozen_string_literal: true

class ObservationImage::Action::DeleteImage < Resources::BulkAction::ModalComponent
  button 'Smazat', icon: 'trash'
  title 'Smazat fotku'

  def perform(resources, _params)
    resources.each(&:destroy)
  end
end

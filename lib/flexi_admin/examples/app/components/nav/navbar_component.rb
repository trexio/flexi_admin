# frozen_string_literal: true

class Nav::NavbarComponent < FlexiAdmin::Components::BaseComponent
  def links
    [
      { name: 'Hřiště', path: playgrounds_path, icon: 'bookshelf' },
      { name: 'Kontroly', path: inspections_path, icon: 'calendar2-check' },
      { name: 'Závady', path: observations_path, icon: 'exclamation-triangle' },
      { name: 'Prvky', path: elements_path, icon: 'boxes' },
      { name: 'divider' },
      { name: 'Nahrát fotky', path: uploads_path, icon: 'camera' },
      { name: 'Nezařazené fotky', path: observation_images_path, icon: 'camera' },
      { name: 'Import protokolu', path: import_protocol_inspections_path, icon: 'file-earmark-text' }
    ]
  end
end

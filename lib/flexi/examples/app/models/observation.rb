# frozen_string_literal: true

class Observation < ApplicationResource
  include PgSearch::Model

  # CodeGen: only create associations that are known from prompt or db schema
  belongs_to :inspected_element
  has_one :element, through: :inspected_element
  has_one :inspection, through: :inspected_element

  has_many :images, class_name: 'ObservationImage', dependent: :destroy
  has_one :cover_image, -> { limit(1) }, class_name: 'ObservationImage'

  attribute :status, :string, default: 'ok'

  # CodeGen: for attribute that imply enum, create enum with few suggested values
  enum status: {
    'OK': 'OK',
    's výhradou': 's výhradou',
    'KO': 'KO'
  }

  pg_search_scope :fulltext,
                  against: %i[description remedy],
                  associated_against: {
                    element: :name
                  },
                  using: { tsearch: { prefix: true } }

  default_scope { joins(:element).where(elements: { is_archived: false }) }

  # CodeGen: create human readable title
  def title
    "#{element.name} - #{description[0..100]}"
  end
  alias ac_title title

  def element_name
    element.name
  end

  def self.ok_observation!(inspected_element)
    Observation.new(description: 'bez závady', inspected_element:)
  end
end

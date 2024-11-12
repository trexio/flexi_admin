# frozen_string_literal: true

module FlexiAdmin::Models::Concerns::Parentable
  extend ActiveSupport::Concern

  included do
    scope :with_parent, lambda { |parent_instance|
      return all if parent_instance.blank?

      plural_name = parent_instance.class.model_name.plural

      association_name = model.reflect_on_all_associations.find { |a| a.plural_name == plural_name }.name

      joins(association_name).where(association_name => { id: parent_instance.id })
    }
  end
end

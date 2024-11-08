# frozen_string_literal: true

class ApplicationResource < ActiveRecord::Base
  primary_abstract_class
  nilify_blanks

  include Parentable

  def identifier
    "#{self.class.name.underscore}_#{id}"
  end
  alias frame_id identifier

  def form_id
    "#{identifier}_form"
  end

  def gid_param
    gid = to_gid

    URI.encode_www_form_component(gid)
  end

  def raw(attribute)
    read_attribute_before_type_cast(attribute)
  end
end

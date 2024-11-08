# frozen_string_literal: true

class Form::FieldComponent < ViewComponent::Base
  slim_template <<-SLIM
    div.field-wrapper.relative.flex.flex-col.grow.pb-2.md:pb-0.leading-tight.min-h-14.h-full.field-wrapper-layout-inline.md:flex-row.md:items-center.field-wrapper-size-regular.field-width-regular
      = content
  SLIM
end

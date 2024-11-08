# frozen_string_literal: true

class Form::RowsComponent < ViewComponent::Base
  slim_template <<-SLIM
    div.divide-y.overflow-auto
      = content
  SLIM
end

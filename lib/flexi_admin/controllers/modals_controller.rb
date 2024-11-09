# frozen_string_literal: true

module FlexiAdmin::Controllers::ModalsController
  def show
    component_class = params[:kind].gsub("-", "/").camelize.constantize

    raise ArgumentError, "scope is required" if context_params.scope.blank?

    context = Resources::Context.from_params(context_params)

    render turbo_stream: turbo_stream.update("modalx_#{context.scope}", component_class.new(context))
  end
end

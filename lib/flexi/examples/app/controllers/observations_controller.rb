# frozen_string_literal: true

class ObservationsController < ResourcesController
  def index
    @observations = Observation.preload(:inspected_element).with_parent(locate_resource(context_params.parent))
    @observations = if params[:order] && params[:sort]
                      @observations.order(params[:sort] => params[:order])
                    else
                      # CodeGen: use relevant parameters of the entity
                      @observations.order(created_at: :desc)
                    end
    @observations = @observations.paginate(**context_params.pagination)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('observations',
                                                  Observation::ResourcesComponent.new(@observations,
                                                                                      scope: 'observations',
                                                                                      context_params:))
      end
    end
  end

  def create; end

  def resource_params
    # CodeGen: use all parameters of the entity
    params.permit(:title, :description, :remedy)
  end
end

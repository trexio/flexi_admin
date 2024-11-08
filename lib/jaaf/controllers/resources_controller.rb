# frozen_string_literal: true

module Jaaf::Controllers::ResourcesController
  # rescue_from RuntimeError, with: :handle_runtime_error

  def handle_runtime_error(error)
    return BugTracker.notify(error) if true

    flash[:error] = Toast.new(error.message)

    render_toasts
  end

  def create
    create_service = begin
      "#{resource_class.model_name.plural.camelize}::Services::Create".constantize
    rescue NameError
      Generic::Services::Create
    end

    result = create_service.run(resource_class:, params: create_params)

    if result.valid?
      redirect_to result.resource
    else
      render_new_resource_form(result.resource)
    end
  end

  def show
    @resource = resource_class.find(params[:id])

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(context_params.frame)
      end
    end
  end

  def edit
    @resource = resource_class.find(params[:id])

    render_edit_resource_form(disabled: context_params.form_disabled)
  end

  def update
    @resource = resource_class.find(params[:id])

    update_service = begin
      "#{resource_class.model_name.plural.camelize}::Services::Update".constantize
    rescue NameError
      Generic::Services::Update
    end

    result = update_service.run(resource: @resource, params: resource_params)

    if result.valid?
      render_edit_resource_form(disabled: true)
    else
      render_edit_resource_form(disabled: false)
    end
  end

  def render_edit_resource_form(disabled: true)
    respond_to do |format|
      format.html do
        render turbo_stream: turbo_stream.replace(@resource.form_id, edit_form_component_instance(disabled))
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@resource.form_id, edit_form_component_instance(disabled))
      end
    end
  end

  def render_new_resource_form(resource)
    respond_to do |format|
      format.html do
        render new_form_component_instance(resource)
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(context_params.frame, new_form_component_instance(resource))
      end
    end
  end

  def bulk_action
    ids = JSON.parse(params[:ids])
    @resources = resource_class.where(id: ids)

    bulk_processor = "#{params[:processor].gsub('-', '/').camelize}::Processor".constantize.new(@resources, params)
    result = bulk_processor.perform

    redirect_to_path result.path and return if result.result == :redirect

    flash[result.result] = Toast.new(result.message)

    reload_page
  end

  def autocomplete(includes: nil)
    base_query = resource_class.with_parent(parent_instance)
                                .fulltext(params[:q])
    base_query = base_query.includes(includes) if includes.present?
    results_count = base_query.count
    results = base_query.limit(100)

    render Jaaf::Components::Shared::Autocomplete::ResultsComponent.new(results:,
                                                                         results_count:,
                                                                         context_params:), layout: false
  end

  def datalist
    results = resource_class.fulltext(params[:q])
                            .limit(100)
                            .order(*context_params.params[:ac_fields].map(&:to_sym))
                            .pluck(*context_params.params[:ac_fields].map(&:to_sym))
                            .uniq
    render Jaaf::Components::Shared::Autocomplete::ResultsComponent.new(results:,
                                                                         context_params:), layout: false
  end

  private

  def parent_instance
    @parent_instance ||= locate_resource(context_params.parent)
  end

  def edit_form_component_instance(disabled)
    "#{@resource.class.name}::Show::EditFormComponent".constantize.new(@resource, disabled:)
  end

  def new_form_component_instance(resource)
    "#{resource.class.name}::NewFormComponent".constantize.new(resource, parent: parent_instance)
  end

  def locate_resource(encoded_gid)
    return nil if encoded_gid.blank?

    gid = URI.decode_www_form_component(encoded_gid)
    resource = GlobalID::Locator.locate(gid)

    raise ActiveRecord::RecordNotFound, "Resource not found: #{encoded_gid}" if resource.blank?

    resource
  end

  def resource_class
    controller_name.classify.constantize
  end
end

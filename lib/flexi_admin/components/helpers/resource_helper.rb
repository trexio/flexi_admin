# frozen_string_literal: true

module FlexiAdmin::Components::Helpers::ResourceHelper
  include FlexiAdmin::Components::Helpers::UrlHelper

  def autocomplete_path(action:, fields:, parent: nil)
    payload = {
      ac_action: action,
      ac_path: resource__path,
      x_parent: parent&.gid_param,
      ac_fields: fields
    }
    main_app.send("autocomplete_#{scope_plural}_path", params: payload)
  end

  def datalist_path(action:, fields:, parent: nil)
    payload = {
      ac_action: action,
      ac_fields: fields
    }

    main_app.send("datalist_#{scope_plural}_path", params: payload)
  end

  def edit_resource_path(resource, **params)
    main_app.send("edit_#{scope_singular}_path", resource, params:)
  end

  def bulk_action_path(scope, **params)
    raise 'Scope is not defined' if scope.blank?

    main_app.send("bulk_action_#{scope}_path", params:)
  end

  def resource_path(resource, **params)
    main_app.send("#{scope_singular}_path", resource, params:)
  end

  def resource__path
    "#{scope_singular}_path"
  end

  def resources_path(**params)
    main_app.send("#{scope_plural}_path", params:)
  end

  def resource_input_name
    "#{scope_singular}_id"
  end

  def scope_plural
    scope.gsub('/', '_')
  end

  def scope_singular
    scope.singularize
  end

  def scope
    @scope ||= begin
      return context.scope if defined?(context)
      return resource.model_name.try(:plural) if defined?(resource)

      raise 'Scope is not defined'
    end
  end

  def paginate(resource, per_page: 10)
    resource.paginate(page: params[:page], per_page:)
  end
end

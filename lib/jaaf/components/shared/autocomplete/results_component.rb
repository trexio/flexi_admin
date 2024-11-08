# frozen_string_literal: true

class Shared::Autocomplete::ResultsComponent < ViewComponent::Base
  attr_reader :results, :results_count, :context_params, :fields, :action, :path

  def initialize(results:, context_params:, results_count: nil)
    @results = results
    @results_count = results_count
    @context_params = context_params
    @action = context_params.params['ac_action']
    @fields = context_params.params['ac_fields']
    @path = context_params.params['ac_path']

    raise 'Action not defined' unless @action
    raise 'Fields not defined' unless @fields
    raise 'Path is required for show action' if action == 'show' && !@path
    return unless results.present? && autocomplete? && fields.any? { |field| !results.first.respond_to?(field.to_sym) }

    raise "Field #{fields} not found on #{results.first.class.name}"
  end

  def data_action
    case action
    when 'select'
      'click->autocomplete#select'
    when 'input'
      'click->autocomplete#inputValue'
    else
      ''
    end
  end

  def value(result)
    return result if datalist?

    fields.map { |field| result.try(field) }.join(' - ')
  end

  def datalist?
    action == 'input'
  end

  def autocomplete?
    action != 'input'
  end
end

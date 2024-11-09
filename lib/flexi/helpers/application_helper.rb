# frozen_string_literal: true

module Flexi::Helpers::ApplicationHelper
  def merge_params(url, params)
    uri = URI(url)
    existing_params = URI.decode_www_form(uri.query || "").to_h
    new_params = existing_params.symbolize_keys.merge(params)
    uri.query = URI.encode_www_form(new_params)
    uri.to_s
  end
end

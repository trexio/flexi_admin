require "gemini-ai"

# frozen_string_literal: true

module FlexiAdmin::Services::CodeGen
  class Gemini
    # Gemini 1.5 Models (Latest)
    MODELS = {
      # Gemini 1.5 Models (Latest)
      gemini_pro: "gemini-1.5-pro-001",
      gemini_pro_latest: "gemini-1.5-pro-002",
      gemini_flash: "gemini-1.5-flash-001",
      gemini_flash_latest: "gemini-1.5-flash-002",

      # Gemini 1.0 Models
      gemini_1_0_pro: "gemini-1.0-pro",
      gemini_1_0_pro_001: "gemini-1.0-pro-001",
      gemini_1_0_pro_002: "gemini-1.0-pro-002",

      # Vision Models
      gemini_pro_vision: "gemini-1.0-pro-vision-001"
    }.freeze

    class Response
      attr_reader :response

      def initialize(response, format:)
        @response = response
        @format = format
      end

      def text
        response.map { |r| r["candidates"].first["content"]["parts"].first["text"] }.join
      end

      def to_h
        JSON.parse(text)
      rescue StandardError
        puts "Error parsing JSON: #{text}"
        {}
      end
      alias as_json to_h

      def usage
        response.usage&.total_tokens
      end
    end

    attr_reader :client

    def build_client(model)
      @client = ::Gemini.new(
        credentials: {
          service: "vertex-ai-api",
          region: "europe-west4",
          file_path: ENV["GOOGLE_APPLICATION_CREDENTIALS"]
        },
        options: { model: MODELS.fetch(model), server_sent_events: true }
      )
    end

    def chat(message, format: "text", model: :gemini_pro, temperature: 0.8, system_prompt: nil)
      request_body = request_body(message, format, system_prompt, temperature)

      response = build_client(model).stream_generate_content(request_body)
      Response.new(response, format: format)
    rescue StandardError => e
      binding.pry if Rails.env.development?
      raise e
    end

    def request_body(message, format, system_prompt = nil, temperature = nil)
      body = {
        contents: [{
          role: "user",
          parts: [{
            text: message
          }]
        }]
      }

      if format.to_s == "json"
        body[:generation_config] = {
          response_mime_type: "application/json"
        }
      end

      # Add optional configurations if provided
      if system_prompt
        body[:system_instruction] = {
          role: "system",
          parts: [{
            text: system_prompt
          }]
        }
      end

      body[:generation_config] ||= {}
      body[:generation_config][:temperature] = temperature if temperature

      body
    end
  end
end

# frozen_string_literal: true

module FlexiAdmin::Services::CodeGen
  class Gpt
    GPT_3_5 = 'gpt-3.5-turbo'
    GPT_3_5_16 = 'gpt-3.5-turbo-16k'
    GPT_4 = 'gpt-4-turbo-2024-04-09'
    GPT_4o = 'gpt-4o'
    GPT_4o_mini = 'gpt-4o-mini'
    GPT_o1 = 'gpt-o1'
    GPT_o1_mini = 'o1-mini'

    class Response
      attr_reader :response

      def initialize(response, format:)
        @response = response
        @format = format
      end

      def text
        response.dig('choices', 0, 'message', 'content')
      end

      def to_h
        JSON.parse(response.dig('choices', 0, 'message', 'content'))
      rescue StandardError
        puts "Error parsing JSON: #{text}"
        {}
      end
      alias as_json to_h

      def usage
        response.dig('usage', 'total_tokens')
      end
    end

    attr_reader :client

    def initialize
      @client = OpenAI::Client.new log_errors: true
    end

    def chat(message, format: 'text', model: GPT_4o, temperature: nil)
      temperature ||= resolve_temperature(model)

      response = client.chat(
        parameters: {
          model: model,
          response_format: { type: format.to_s == 'json' ? 'json_object' : 'text' },
          messages: [{ role: 'user', content: message }],
          temperature: temperature
        }
      )

      Response.new(response, format:)
    end

    def resolve_temperature(model)
      case model
      when GPT_o1, GPT_o1_mini
        1
      else
        0.7
      end
    end
  end
end
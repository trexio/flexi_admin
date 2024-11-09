# frozen_string_literal: true

module FlexiAdmin
  class Config
    class Store
      attr_accessor :chat_client, :llm_client
      attr_reader :functions

      attr_writer :controller_class
    end

    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= FlexiAdmin::Config::Store.new
      end

      def configure
        yield(configuration)
      end
    end
  end
end

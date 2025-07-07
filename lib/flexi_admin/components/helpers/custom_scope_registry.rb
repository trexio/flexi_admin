# frozen_string_literal: true

module FlexiAdmin::Components::Helpers
  class CustomScopeRegistry
    @registry = {}

    class << self
      def register(key, scope_or_proc)
        @registry[key.to_s] = scope_or_proc
      end

      def get(key)
        @registry[key.to_s]
      end

      def clear!
        @registry.clear
      end
    end
  end
end

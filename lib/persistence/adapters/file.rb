# frozen_string_literal: true

require "yaml/store"

module Persistence
  module Adapters
    class File
      attr_reader :store

      def initialize(path)
        @store = YAML::Store.new(path + ".yml")
      end

      def get(key)
        value = nil
        store.transaction do
          value = store[key]
        end
      end

      def set(key, value)
        store.transaction do
          store[key] = value.to_s
        end
      end
    end
  end
end

# frozen_string_literal: true

module Persistence
  class Store
    attr_reader :adapter

    def initialize(adapter)
      @adapter = adapter
    end

    def last_run
      adapter.get("last_run")
    end

    def store_last_run(value)
      adapter.set("last_run", value)

      value
    end
  end
end

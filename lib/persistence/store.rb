module Persistence
  class Store
    attr_reader :adapter

    def initialize(adapter)
      @adapter = adapter
    end

    def last_run
      adapter.get("last_run")
    end

    def store_last_run(value = DateTime.now)
      adapter.set("last_run", value)
    end
  end
end

# frozen_string_literal: true

require "test_helper"

module Persistence
  class StoreTest < Minitest::Test
    def test_last_run_calls_get
      adapter = Minitest::Mock.new
      adapter.expect :get, :return_value, %w[last_run]

      object = Store.new(adapter)
      assert_equal :return_value, object.last_run

      adapter.verify
    end

    def test_store_last_run_calls_set
      adapter = Minitest::Mock.new
      adapter.expect :set, nil, %w[last_run new_value]

      object = Store.new(adapter)
      object.store_last_run("new_value")

      adapter.verify
    end

    def test_store_last_run_calls_returns_value
      adapter = Minitest::Mock.new
      adapter.expect :set, nil, %w[last_run new_value]

      object = Store.new(adapter)
      assert_equal "new_value", object.store_last_run("new_value")
    end
  end
end

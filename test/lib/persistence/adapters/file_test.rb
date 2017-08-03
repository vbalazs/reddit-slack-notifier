require "test_helper"

module Persistence
  module Adapters
    class FileTest < Minitest::Test
      def setup
        @write_test_path = __dir__ + "write_test.yml"
      end

      def teardown
        ::File.delete(@write_test_path) if ::File.exist?(@write_test_path)
      end

      def test_get_value_from_fixture
        object = File.new(__dir__ + "/file_fixture")

        assert_equal "my_value", object.get("test_key")
      end

      def test_set_stores_in_file
        object = File.new(__dir__ + "write_test")
        object.set("write_test_key", "new_value")

        store = YAML::Store.new(@write_test_path)

        store.transaction do
          assert_equal "new_value", store["write_test_key"]
        end
      end
    end
  end
end

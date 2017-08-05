require "test_helper"

module Clients
  module Slack
    class ChannelSelectorTest < Minitest::Test
      def test_when_whitelist_empty_returns_default
        object = build("my-test", [])
        assert_equal %w[my-test], object.channels(%w[ruby])
      end

      def test_when_no_tags_found_returns_default
        object = build("my-test", %w[java])
        assert_equal %w[my-test], object.channels([])
      end

      def test_when_all_tags_filtered_by_whitelist_returns_default
        object = build("my-test", %w[java])
        assert_equal %w[my-test], object.channels(%w[ruby])
      end

      def test_tags_filtered_by_whitelist
        object = build("my-test", %w[java kotlin jvm])
        assert_equal %w[java jvm], object.channels(%w[java jvm])
      end

      private

      def build(default, whitelist)
        ChannelSelector.new(default: default, whitelist: whitelist)
      end
    end
  end
end

require "test_helper"

module Clients
  module Reddit
    class NewPostsQueryTest < Minitest::Test
      include ReddFactories

      def test_between_returns_within_range
        new_posts = [
          build_redd_submission(title: "first", created_utc: 1_490_158_800),
          build_redd_submission(title: "second", created_utc: 1_490_158_801),
          build_redd_submission(title: "third", created_utc: 1_490_158_802)
        ]

        time_start = 1_490_158_801
        time_end = 1_490_158_803

        object = build_object

        object.stub :new_posts, new_posts do
          results = object.between(time_start..time_end)

          assert_equal 2, results.size
          assert_equal "second", results[0].title
          assert_equal "third", results[1].title
        end
      end

      def test_between_returns_mapped_objects
        post = build_redd_submission(
          title: "first",
          created_utc: 1_490_158_801
        )

        time_start = 1_490_158_801
        time_end = 1_490_158_803

        object = build_object

        object.stub :new_posts, [post] do
          result = object.between(time_start..time_end).first

          assert_kind_of Post, result
        end
      end

      private

      def build_object
        NewPostsQuery.new(nil, nil)
      end
    end
  end
end

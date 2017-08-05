require "test_helper"

module Clients
  module Reddit
    class PostTest < Minitest::Test
      include ReddFactories

      def test_initializes_from_submission
        submission = build_redd_submission(
          title: "[my_tag] Super title",
          author: "goodGuy",
          permalink: "/r/site131/comments/6qmvpe/super_title/",
          url: "http://google.com/x",
          thumbnail: "http://thumbnail.com/image",
          subreddit_name_prefixed: "r/site131",
          created_utc: 1_490_158_800
        )

        object = Clients::Reddit::Post.new(submission)

        assert_equal "[my_tag] Super title", object.title
        assert_equal "goodGuy", object.author
        assert_equal "/r/site131/comments/6qmvpe/super_title/", object.permalink
        assert_equal "http://google.com/x", object.url
        assert_equal "http://thumbnail.com/image", object.thumbnail
        assert_equal "r/site131", object.subreddit
        assert_equal 1_490_158_800, object.posted_at
      end

      def test_title_delegators
        submission = build_redd_submission(title: "[my_tag] Super title")

        object = Clients::Reddit::Post.new(submission)

        assert_equal "Super title", object.title_without_tags
        assert_equal ["my_tag"], object.tags
      end
    end
  end
end

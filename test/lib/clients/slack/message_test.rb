require "test_helper"

module Clients
  module Slack
    class MessageTest < Minitest::Test
      # rubocop:disable Metrics/MethodLength
      def test_as_attachment
        expected = {
          "fallback" => "New post on Reddit by bobby: Super new post - https://x.y/z",
          "color" => "#36a64f",
          "pretext" => "New post on Reddit by bobby",
          "author_name" => "pics",
          "author_link" => "https://www.reddit.com/r/pics",
          "author_icon" => "https://www.redditstatic.com/spreddit5.gif",
          "image_url" => "http://images.im/abc",
          "title" => "Super new post",
          "title_link" => "https://x.y/z",
          "ts" => "1501025640"
        }

        message = Message.new(
          "title" => "Super new post",
          "author" => "bobby",
          "post_url" => "https://x.y/z",
          "image_url" => "http://images.im/abc",
          "subreddit" => "pics",
          "posted_at" => "July 25, 2017 at 11:34PM"
        )

        assert_equal expected, message.as_attachment
      end
      # rubocop:enable Metrics/MethodLength

      def test_title_without_tags
        msg = Message.new("title" => "[ruby] Awesome article")
        expected = "Awesome article"
        assert_equal expected, msg.as_attachment["title"]
        assert_includes msg.as_attachment["fallback"], expected
      end
    end
  end
end

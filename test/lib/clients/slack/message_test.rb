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
          "author_link" => "https://www.reddit.com/a/comments/bla",
          "author_icon" => "https://www.redditstatic.com/spreddit5.gif",
          "image_url" => "http://images.im/abc",
          "title" => "Super new post",
          "title_link" => "https://x.y/z",
          "ts" => 1_501_025_640
        }

        message = Message.new(
          "title" => "Super new post",
          "author" => "bobby",
          "post_url" => "https://x.y/z",
          "image_url" => "http://images.im/abc",
          "subreddit" => "pics",
          "permalink" => "/a/comments/bla",
          "posted_at" => 1_501_025_640
        )

        assert_equal expected, message.as_attachment
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end

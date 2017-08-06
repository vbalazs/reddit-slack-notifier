# frozen_string_literal: true

require "test_helper"

module Clients
  module Reddit
    class PostTest < Minitest::Test
      include ReddFactories

      def test_initializes_from_submission_title
        assert_equal "[my_tag] Super title", custom_post.title
      end

      def test_initializes_from_submission_author
        assert_equal "goodGuy", custom_post.author
      end

      def test_initializes_from_submission_permalink
        assert_equal "/r/site131/comments/6qmvpe/super_title/", custom_post.permalink
      end

      def test_initializes_from_submission_url
        assert_equal "http://google.com/x", custom_post.url
      end

      def test_initializes_from_submission_thumbnail
        assert_equal "http://thumbnail.com/image", custom_post.thumbnail
      end

      def test_initializes_from_submission_subreddit
        assert_equal "r/site131", custom_post.subreddit
      end

      def test_initializes_from_submission_posted_at
        assert_equal 1_490_158_800, custom_post.posted_at
      end

      def test_title_delegators
        submission = build_redd_submission(title: "[my_tag] Super title")

        object = Clients::Reddit::Post.new(submission)

        assert_equal "Super title", object.title_without_tags
        assert_equal ["my_tag"], object.tags
      end

      private

      def custom_post
        Clients::Reddit::Post.new(
          build_redd_submission(
            title: "[my_tag] Super title",
            author: "goodGuy",
            permalink: "/r/site131/comments/6qmvpe/super_title/",
            url: "http://google.com/x",
            thumbnail: "http://thumbnail.com/image",
            subreddit_name_prefixed: "r/site131",
            created_utc: 1_490_158_800
          )
        )
      end
    end
  end
end

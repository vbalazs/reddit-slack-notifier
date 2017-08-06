# frozen_string_literal: true

module Clients
  module Slack
    class Message
      attr_reader :title, :tags, :author, :post_url, :permalink,
                  :image_url, :subreddit, :posted_at

      def initialize(params = {})
        @title = params["title"]
        @tags = params["tags"]
        @author = params["author"]
        @post_url = params["post_url"]
        @permalink = params["permalink"]
        @image_url = params["image_url"]
        @subreddit = params["subreddit"]
        @posted_at = params["posted_at"]
      end

      def as_attachment
        {
          "fallback"    => "#{pretext}: #{title} - #{post_url}",
          "color"       => "#36a64f",
          "pretext"     => pretext,
          "author_name" => subreddit,
          "author_link" => "https://www.reddit.com#{permalink}",
          "author_icon" => "https://www.redditstatic.com/spreddit5.gif",
          "image_url"   => image_url,
          "title"       => title,
          "title_link"  => post_url,
          "ts"          => posted_at
        }
      end

      private

      def pretext
        "New post on Reddit by #{author}"
      end
    end
  end
end

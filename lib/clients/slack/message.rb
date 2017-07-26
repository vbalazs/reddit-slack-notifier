module Clients
  module Slack
    class Message
      attr_reader :title, :author, :post_url, :image_url, :subreddit, :posted_at

      def initialize(params = {})
        @title = params["title"]
        @author = params["author"]
        @post_url = params["post_url"]
        @image_url = params["image_url"]
        @subreddit = params["subreddit"]
        @posted_at = params["posted_at"]
      end

      def as_attachment
        {
          "fallback"    => "#{pretext}: #{title_without_tags} - #{post_url}",
          "color"       => "#36a64f",
          "pretext"     => pretext,
          "author_name" => subreddit,
          "author_link" => "https://www.reddit.com/r/#{subreddit}",
          "author_icon" => "https://www.redditstatic.com/spreddit5.gif",
          "image_url"   => image_url,
          "title"       => title_without_tags,
          "title_link"  => post_url,
          "ts"          => timestamp
        }
      end

      private

      def pretext
        "New post on Reddit by #{author}"
      end

      def timestamp
        parsed_date = begin
          DateTime.parse(posted_at.to_s)
        rescue ArgumentError
          DateTime.now
        end

        parsed_date.strftime("%s")
      end

      def title_without_tags
        # http://rubular.com/r/8Hc5JMaaDE
        /^(\[\s*[\w-]*\s*\]\s*)*(.*)$/.match(title)[2]
      end
    end
  end
end

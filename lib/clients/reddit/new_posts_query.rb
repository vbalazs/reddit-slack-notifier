module Clients
  module Reddit
    class NewPostsQuery
      attr_reader :session, :subreddit

      def initialize(session, subreddit = nil)
        @session = session
        @subreddit = subreddit || "aww"
      end

      def between(timestamp_range)
        within_range = new_posts.select { |post| timestamp_range.cover? post.created_utc }

        within_range.map { |post| Post.new(post) }
      end

      def new_posts
        session.subreddit(subreddit).new.to_ary
      end
    end
  end
end

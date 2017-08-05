require "forwardable"

module Clients
  module Reddit
    class Post
      extend Forwardable
      def_delegators :@post_title, :title, :title_without_tags, :tags

      attr_reader :author, :permalink, :url, :subreddit, :posted_at

      def initialize(submission)
        @post_title = PostTitle.new(submission.title)
        @author = submission.author.name
        @permalink = submission.permalink
        @url = submission.url
        @subreddit = submission.subreddit_name_prefixed
        @posted_at = submission.created_utc
      end
    end
  end
end

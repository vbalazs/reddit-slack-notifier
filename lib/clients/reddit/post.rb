require "forwardable"

module Clients
  module Reddit
    class Post
      extend Forwardable
      def_delegators :@post_title, :title, :title_without_tags, :tags

      attr_reader :author, :permalink, :url, :subreddit

      def initialize(submission)
        @post_title = PostTitle.new(submission.title)
        @author = submission.author.name
        @permalink = submission.permalink
        @url = submission.url
        @subreddit = submission.subreddit_name_prefixed
      end
    end
  end
end

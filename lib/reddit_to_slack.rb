# frozen_string_literal: true

class RedditToSlack
  attr_reader :slack_client, :reddit_query_object

  def initialize(slack_client:, reddit_query_object:)
    @slack_client = slack_client
    @reddit_query_object = reddit_query_object
  end

  def call(timestamp_range)
    posts = reddit_query_object.between(timestamp_range)

    messages = posts.map { |post| build_message(post) }

    messages.each do |msg|
      slack_client.post(msg)
    end
  end

  private

  def build_message(post)
    Clients::Slack::Message.new(
      "title" => post.title_without_tags,
      "tags" => post.tags,
      "author" => post.author,
      "post_url" => post.url,
      "permalink" => post.permalink,
      "image_url" => post.thumbnail,
      "subreddit" => post.subreddit,
      "posted_at" => post.posted_at
    )
  end
end

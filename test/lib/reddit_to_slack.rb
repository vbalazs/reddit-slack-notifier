# frozen_string_literal: true

require "test_helper"

class SchedulerTest < Minitest::Test
  include ReddFactories

  def test_sends_posts_to_slack
    slack_client = Minitest::Mock.new
    2.times { slack_client.expect(:post, true, [Clients::Slack::Message]) }
    posts = [build_post, build_post]

    reddit_query_object = Clients::Reddit::NewPostsQuery.new
    object = build_object(slack_client, reddit_query_object)
    r
    reddit_query_object.stub :between, posts do
      object.call(0)
    end

    slack_client.verify
  end

  private

  def build_object(slack_client, reddit_query_object)
    RedditToSlack.new(
      slack_client: slack_client,
      reddit_query_object: reddit_query_object
    )
  end

  def build_post
    Clients::Reddit::Post.new(build_redd_submission)
  end
end

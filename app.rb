# frozen_string_literal: true

require "bundler"
Bundler.setup(:default)
require_relative "load"

class App
  def run
    current_run = Time.now.utc.to_i
    previous_run = (persistence.last_run || current_run).to_i

    timestamp_range = previous_run..current_run
    reddit_to_slack.call(timestamp_range) if timestamp_range.size > 1

    persistence.store_last_run(current_run)
  end

  def config
    @config ||= begin
      reddit_user = ENV.fetch("REDDIT_USER")
      default_user_agent = "Redd:RedditToSlack-rb:v1.0.0 (by /u/#{reddit_user})"
      {
        reddit_user: reddit_user,
        reddit_password: ENV.fetch("REDDIT_PASSWORD"),
        reddit_subreddit: ENV.fetch("REDDIT_SUBREDDIT", "aww"),
        reddit_app_user_agent: ENV.fetch("REDDIT_APP_USER_AGENT", default_user_agent),
        reddit_app_client_id: ENV.fetch("REDDIT_APP_CLIENT_ID"),
        reddit_app_secret: ENV.fetch("REDDIT_APP_SECRET"),
        slack_incoming_webhook_url: ENV.fetch("SLACK_INCOMING_WEBHOOK_URL"),
        slack_default_channel: ENV.fetch("SLACK_DEFAULT_CHANNEL", "random"),
        slack_channels_whitelist: ENV.fetch("SLACK_CHANNELS_WHITELIST", "").split(","),
        store: ENV.fetch("STORE", "#{__dir__}/db")
      }
    end
  end

  def reddit_session
    @reddit_session ||= begin
      Redd.it(
        user_agent: config[:reddit_app_user_agent],
        client_id:  config[:reddit_app_client_id],
        secret:     config[:reddit_app_secret],
        username:   config[:reddit_user],
        password:   config[:reddit_password]
      )
    end
  end

  def reddit_query_object
    Clients::Reddit::NewPostsQuery.new(reddit_session, config[:reddit_subreddit])
  end

  def reddit_to_slack
    RedditToSlack.new(
      slack_client: slack_client,
      reddit_query_object: reddit_query_object
    )
  end

  def persistence
    @store ||= begin
      adapter = Persistence::Adapters::File.new(config[:store])
      Persistence::Store.new(adapter)
    end
  end

  def slack_client
    Clients::Slack::Notifier.new(
      url: config[:slack_incoming_webhook_url],
      channel_selector: channel_selector
    )
  end

  def channel_selector
    Clients::Slack::ChannelSelector.new(
      default: config[:slack_default_channel],
      whitelist: config[:slack_channels_whitelist]
    )
  end
end

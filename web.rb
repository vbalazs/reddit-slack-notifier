require "bundler"
require "json"
Bundler.require

class UnathorizedRequest < StandardError; end

class Web < Rack::App
  desc "Root"
  get "/" do
    "Set ifttt.com applet target to POST /ifttt"
  end

  desc "Healthcheck"
  get "/health" do
    "OK"
  end

  desc "IFTTT recipe target: Reddit new post from search with fully customizable webhook"
  post "/ifttt" do
    body = JSON.parse(request.body.read)
    ifttt_token_cfg = ENV.fetch("IFTTT_APPLET_TOKEN")
    ifttt_client = Clients::Ifttt.new(json: body, token: ifttt_token_cfg)

    Http::Actions::PostIfttt.new(
      ifttt_client: ifttt_client,
      slack_client: slack_client
    ).call
  end

  error UnathorizedRequest do |_|
    response.status = 401
  end

  def slack_client
    url = ENV.fetch("SLACK_INCOMING_WEBHOOK_URL")

    Clients::Slack::Notifier.new(url: url, channel_selector: channel_selector)
  end

  def channel_selector
    whitelist = ENV.fetch("SLACK_CHANNELS_WHITELIST", "").split(",")
    default_channel = ENV.fetch("SLACK_DEFAULT_CHANNEL", "random")

    Clients::Slack::ChannelSelector.new(default: default_channel, whitelist: whitelist)
  end
end

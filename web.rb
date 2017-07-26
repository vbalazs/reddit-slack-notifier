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
    client = Clients::Ifttt.new(json: body, token: ifttt_token_cfg)

    Http::Actions::PostIfttt.new(ifttt_client: client).call
  end

  error UnathorizedRequest do |_|
    response.status = 401
  end
end

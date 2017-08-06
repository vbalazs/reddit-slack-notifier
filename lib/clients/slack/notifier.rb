# frozen_string_literal: true

require "net/http"

module Clients
  module Slack
    class Notifier
      attr_reader :url, :channel_selector

      def initialize(url:, channel_selector:)
        @url = URI(url)
        @channel_selector = channel_selector
      end

      def post(message)
        channels = channel_selector.channels(message.tags)

        channels.each do |channel|
          body = {
            "channel" => channel,
            "attachments" => [message.as_attachment]
          }.to_json

          notify(body)
        end
      end

      private

      def notify(body)
        response = Net::HTTP.post(url, body, "Content-Type" => "application/json")

        case response
        when Net::HTTPSuccess then
          response.body == "ok"
        else
          LOGGER.error("Failed to post to Slack: #{response.class} ; #{response.body}")
          false
        end
      end
    end
  end
end

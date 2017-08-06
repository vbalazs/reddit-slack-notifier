# frozen_string_literal: true

require "test_helper"

module Clients
  module Slack
    class NotifierTest < Minitest::Test
      def test_posts_to_multiple_channels
        stub_request(:any, /example/)

        channel_selector = build_channel_selector
        notifier = build_object(channel_selector)
        channels_list = %w[ruby java]

        channel_selector.stub :channels, channels_list do
          notifier.post(build_message)

          channels_list.each do |tag|
            assert_requested(:post, "https://www.example.com/hooks/abc") do |req|
              JSON.parse(req.body)["channel"] == tag
            end
          end
        end
      end

      # rubocop:disable Metrics/AbcSize
      def test_has_message_attachment
        stub_request(:any, /example/)

        channel_selector = build_channel_selector
        notifier = build_object(channel_selector)

        channel_selector.stub :channels, ["ruby"] do
          notifier.post(build_message)

          assert_requested(:post, "https://www.example.com/hooks/abc") do |req|
            attachments = JSON.parse(req.body)["attachments"]

            attachments.size == 1 &&
              attachments[0]["image_url"] == "http://images.com/x.jpg"
          end
        end
      end
      # rubocop:enable Metrics/AbcSize

      private

      def build_channel_selector
        ChannelSelector.new(default: "", whitelist: [])
      end

      def build_message
        Message.new("image_url" => "http://images.com/x.jpg")
      end

      def build_object(channel_selector)
        Notifier.new(url: "https://www.example.com/hooks/abc", channel_selector: channel_selector)
      end
    end
  end
end

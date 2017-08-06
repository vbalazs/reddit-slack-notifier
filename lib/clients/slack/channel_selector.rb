# frozen_string_literal: true

module Clients
  module Slack
    class ChannelSelector
      attr_reader :default, :whitelist

      def initialize(default:, whitelist:)
        @whitelist = whitelist
        @default = default
      end

      def channels(tags)
        channels = filtered_channels(tags)
        return [default] if channels.empty?

        channels
      end

      private

      def filtered_channels(tags)
        whitelist & tags
      end
    end
  end
end

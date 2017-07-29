module Clients
  module Slack
    class ChannelSelector
      attr_reader :default, :whitelist

      def initialize(default:, whitelist:)
        @whitelist = whitelist
        @default = default
      end

      def channels(title)
        channels = filtered_channels(title)
        return [default] if channels.empty?

        channels
      end

      private

      def filtered_channels(title)
        parsed_title = Reddit::PostTitle.new(title)

        whitelist & parsed_title.tags
      end
    end
  end
end

module Http
  module Actions
    class PostIfttt
      attr_reader :ifttt_client, :slack_client

      def initialize(ifttt_client:, slack_client:)
        @ifttt_client = ifttt_client
        @slack_client = slack_client
      end

      def call
        raise UnathorizedRequest unless ifttt_client.authorized?

        LOGGER.debug { "new post: #{ifttt_client.params}" }

        message = Clients::Slack::Message.new(ifttt_client.params)

        slack_client.post(message)

        "OK"
      end
    end
  end
end

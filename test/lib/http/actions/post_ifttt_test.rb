require "test_helper"

module Http
  module Actions
    class PostIftttTest < Minitest::Test
      def setup
        @slack_client = Minitest::Mock.new
        @slack_client.expect :post, nil, [Clients::Slack::Message]
      end

      def test_raises_unauthorized
        ifttt_client = build_ifttt_client
        action = build_action(ifttt_client)

        ifttt_client.stub :authorized?, false do
          assert_raises UnathorizedRequest do
            action.call
          end
        end
      end

      def test_returns_ok_when_authorized
        ifttt_client = build_ifttt_client
        action = build_action(ifttt_client)

        ifttt_client.stub :authorized?, true do
          assert_equal "OK", action.call
        end
      end

      def test_calls_slack_client_post
        ifttt_client = build_ifttt_client
        action = build_action(ifttt_client)

        ifttt_client.stub :authorized?, true do
          action.call
        end

        @slack_client.verify
      end

      private

      def build_action(ifttt_client)
        Http::Actions::PostIfttt.new(
          ifttt_client: ifttt_client,
          slack_client: @slack_client
        )
      end

      def build_ifttt_client
        Clients::Ifttt.new(json: {}, token: "")
      end
    end
  end
end

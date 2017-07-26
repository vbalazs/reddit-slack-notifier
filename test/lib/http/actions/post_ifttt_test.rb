require "test_helper"

module Http
  module Actions
    class PostIftttTest < Minitest::Test
      def test_raises_unauthorized
        client = build_client
        action = build_action(client)

        client.stub :authorized?, false do
          assert_raises UnathorizedRequest do
            action.call
          end
        end
      end

      def test_returns_ok_when_authorized
        client = build_client
        action = build_action(client)

        client.stub :authorized?, true do
          assert_equal "OK", action.call
        end
      end

      private

      def build_action(client)
        Http::Actions::PostIfttt.new(ifttt_client: client)
      end

      def build_client
        Clients::Ifttt.new(json: {}, token: "")
      end
    end
  end
end

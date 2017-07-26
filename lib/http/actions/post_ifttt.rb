module Http
  module Actions
    class PostIfttt
      attr_reader :ifttt_client

      def initialize(ifttt_client:)
        @ifttt_client = ifttt_client
      end

      def call
        raise UnathorizedRequest unless ifttt_client.authorized?

        LOGGER.debug { "new post: #{ifttt_client.params}" }

        "OK"
      end
    end
  end
end

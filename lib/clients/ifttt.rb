module Clients
  class Ifttt
    attr_reader :json, :token

    def initialize(json:, token:)
      @json = json
      @token = token
    end

    def authorized?
      !token.to_s.empty? && token == json["token"]
    end

    def params
      keys = %w[title post_url author image_url subreddit posted_at]
      json.select { |k, _| keys.include?(k) }
    end
  end
end

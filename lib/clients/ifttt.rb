module Clients
  class Ifttt
    attr_reader :json, :token

    def initialize(json:, token:)
      @json = json
      @token = token
    end

    def authorized?
      json["token"] == token
    end

    def params
      keys = %w[title author post_url]
      json.select { |k, _| keys.include?(k) }
    end
  end
end

require "test_helper"

module Clients
  class IftttTest < Minitest::Test
    def test_authorized_happy
      input = { "token" => "abc" }

      assert build_client(input).authorized?
    end

    def test_unathorized
      input = { "token" => "xyz" }

      refute build_client(input).authorized?
    end

    def test_when_empty_token_then_unathorized
      input = { "token" => "xyz" }

      refute Ifttt.new(json: input, token: "").authorized?
    end

    def test_params
      input = {
        "random" => "x",
        "title" => "Super Post",
        "author" => "Person",
        "post_url" => "http://google.com",
        "image_url" => "https://images.com/image.jpg",
        "subreddit" => "pics",
        "posted_at" => "yesterday"
      }

      assert_equal({
                     "title" => "Super Post",
                     "author" => "Person",
                     "post_url" => "http://google.com",
                     "image_url" => "https://images.com/image.jpg",
                     "subreddit" => "pics",
                     "posted_at" => "yesterday"
                   }, build_client(input).params)
    end

    private

    def build_client(input)
      Ifttt.new(json: input, token: "abc")
    end
  end
end

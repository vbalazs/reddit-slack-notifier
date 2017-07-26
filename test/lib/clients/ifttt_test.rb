require "test_helper"

module Clients
  class TestIfttt < Minitest::Test
    def test_authorized_happy
      input = { "token" => "abc" }

      assert build_client(input).authorized?
    end

    def test_authorized_unhappy
      input = { "token" => "xyz" }

      refute build_client(input).authorized?
    end

    def test_params
      input = {
        "random" => "x",
        "title" => "Super Post",
        "author" => "Person",
        "post_url" => "http://google.com"
      }

      assert_equal({
                     "title" => "Super Post",
                     "author" => "Person",
                     "post_url" => "http://google.com"
                   }, build_client(input).params)
    end

    private

    def build_client(input)
      Ifttt.new(json: input, token: "abc")
    end
  end
end

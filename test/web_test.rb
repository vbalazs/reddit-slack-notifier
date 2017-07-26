require "test_helper"
require "web"
require "rack/app/test"

class WebTest < Minitest::Test
  include Rack::App::Test

  rack_app Web

  def setup
    ENV["IFTTT_APPLET_TOKEN"] = "abc"
  end

  def test_root
    response = get(url: "/health")
    assert_equal 200, response.status
    refute_empty response.body
  end

  def test_healthcheck
    response = get(url: "/health")
    assert_equal 200, response.status
    assert_equal "OK", response.body
  end

  def test_ifttt_unauthorized
    response = post(url: "/ifttt",
                    headers: { "Content-Type" => "application/json" },
                    payload: "{}")

    assert_equal 401, response.status
  end

  def test_ifttt_returns_ok
    skip "this is a glorified testcase with too many deps"
    subject.stub :slack_client, Minitest::Mock.new do
      response = post(url: "/ifttt",
                    headers: { "Content-Type" => "application/json" },
                    payload: { token: "abc" }.to_json)

      assert_equal 200, response.status
      assert_equal "OK", response.body
    end
  end
end

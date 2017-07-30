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

  def test_when_ifttt_unauthorized_returns_401
    response = post(url: "/ifttt",
                    headers: { "Content-Type" => "application/json" },
                    payload: "{}")

    Http::Actions::PostIfttt.any_instance.stubs(:call).raises(UnathorizedRequest)

    assert_equal 401, response.status
  end

  def test_ifttt_returns_ok
    Http::Actions::PostIfttt.any_instance.stubs(:call).returns("OK")

    response = post(url: "/ifttt",
                    headers: { "Content-Type" => "application/json" },
                    payload: "{}")

    assert_equal 200, response.status
    assert_equal "OK", response.body
  end
end

require "test_helper"
require "app"

class AppTest < Minitest::Test
  def test_run_stores_last_run_time
    app = App.new
    persistence = mock("persistence")
    persistence.stubs(:last_run).returns(nil)
    app.stubs(:persistence).returns(persistence)

    Time.any_instance.expects(:utc).returns(5)
    persistence.expects(:store_last_run).with(5)

    app.run
  end

  def test_run_when_no_previous_run_skips_call
    app = App.new

    persistence = stub("persistence", last_run: nil, store_last_run: nil)
    app.stubs(:persistence).returns(persistence)

    reddit_to_slack = mock("reddit_to_slack")
    reddit_to_slack.expects(:call).never
    app.stubs(:reddit_to_slack).returns(reddit_to_slack)

    app.run
  end

  def test_run_calls_with_correct_timestamp_range
    app = App.new

    Time.any_instance.expects(:utc).returns(10)
    persistence = stub("persistence", last_run: 5, store_last_run: nil)
    app.stubs(:persistence).returns(persistence)

    reddit_to_slack = mock("reddit_to_slack")
    reddit_to_slack.expects(:call).with(5..10)
    app.stubs(:reddit_to_slack).returns(reddit_to_slack)

    app.run
  end
end

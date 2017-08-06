# Reddit post Slack notifications

[![Codeship Status for vbalazs/reddit-slack-notifier](https://app.codeship.com/projects/c715e4d0-5d12-0135-2a2f-166fbfd22a33/status?branch=master)](https://app.codeship.com/projects/238054) [![Dependency Status](https://gemnasium.com/badges/github.com/vbalazs/reddit-slack-notifier.svg)](https://gemnasium.com/github.com/vbalazs/reddit-slack-notifier) [![Code Climate](https://codeclimate.com/github/vbalazs/reddit-slack-notifier/badges/gpa.svg)](https://codeclimate.com/github/vbalazs/reddit-slack-notifier) [![Test Coverage](https://codeclimate.com/github/vbalazs/reddit-slack-notifier/badges/coverage.svg)](https://codeclimate.com/github/vbalazs/reddit-slack-notifier/coverage) [![Issue Count](https://codeclimate.com/github/vbalazs/reddit-slack-notifier/badges/issue_count.svg)](https://codeclimate.com/github/vbalazs/reddit-slack-notifier)

Sends notification to Slack about new Reddit posts.
The motivation was that we are using with a private subreddit as a forum but we lacked notifications about new posts.

It can send notifications into multiple channels specified by tags in the reddit post's title. 
Some examples:
* Reddit post title: "[ruby] Ruby is awesome" -> posts it to the `ruby` channel
* Reddit post title: "[elixir][kotlin] What to learn next?" -> posts it to the `elixir` and `kotlin` channels
* Reddit post title: "What to do on our next team building?" -> posts it to the channel set as default

It does not check for channel existance on Slack therefore posts tagged with non-existent channels will be ignored.

# How to use

## 1. Make sure you have the correct ruby version installed

Refer to [.ruby-version](.ruby-version).

## 2. Configuration

The application uses environment variables for configuration:

`LOG_LEVEL`: level supported by Ruby [`Logger`](http://ruby-doc.org/stdlib-2.4.1/libdoc/logger/rdoc/Logger.html). It logs to STDOUT so you might want to redirect the output of the script to a file.
Default: `info`.

`SLACK_INCOMING_WEBHOOK_URL`: Slack webhook url, something like: https://hooks.slack.com/services/XXXXXYYYYZZ
Specify your slack bot settings here: name, avatar, etc.

`SLACK_DEFAULT_CHANNEL`: If no tags found or the tag is not in the whitelist, the notification will be sent here.
Default: `random`

`SLACK_CHANNELS_WHITELIST`: Comma separated lists of channels where the notifier allowed to send messages. Add defualt channel explicitly if you want to allow that in a multiple tags scenario.
For example: `ruby,elixir,dev-ops,r_lang`

`REDDIT_USER`, `REDDIT_PASSWORD`: The credentials of your or your bot's user on Reddit

`REDDIT_SUBREDDIT`: The subreddit will be polled for new posts.
Default: `aww`

`REDDIT_APP_CLIENT_ID`, `REDDIT_APP_SECRET`: Create an app on [Reddit](https://www.reddit.com/prefs/apps/) with `script` type. Fill `redirect uri` with some bogus value, it's not used.

`REDDIT_APP_USER_AGENT`: Set your User-Agent for Reddit, you can read about this in their [API rules](https://github.com/reddit/reddit/wiki/API#rules)
Default: `Redd:RedditToSlack-rb:v1.0.0 (by /u/$YOUR_REDDIT_USER)`

`STORE`: At the moment just a YAML file is supported to store "last_run" information between executions. You can specify a file path without the extension.
Default: `$app_dir/db`

## 3. Install the dependencies

`bundle install`

## Schedule the script

Use your favourite tools and methods, for example with cron:

`*/1 * * * * source ~/env.sh && cd ~/app && bundle exec run.rb >> logs/app.log 2>>logs/stderr.log`

**Notice**
Don't set the interval too short because the script runs might overlap and you will have a bad time (probably duplicated slack notifications).
Also, watch out for reddit API [rate limits](https://github.com/reddit/reddit/wiki/API#rules).

# Use at your own risk!

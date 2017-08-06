require_relative "../load"
require "minitest/autorun"
require "minitest/pride"
require "webmock/minitest"
require "mocha/mini_test"

require_relative "redd_factories"

LOGGER.level = "unknown" # mute it

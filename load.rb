# frozen_string_literal: true

$LOAD_PATH.unshift(__dir__) unless $LOAD_PATH.include?(__dir__)

require "json"
require "redd"
require "config/logger"

Dir["lib/**/*.rb"].each { |file| require file }

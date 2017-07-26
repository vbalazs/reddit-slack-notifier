require "logger"

LOGGER = Logger.new(STDOUT)
LOGGER.level = ENV.fetch("LOG_LEVEL", "info")

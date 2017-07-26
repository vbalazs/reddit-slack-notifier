$LOAD_PATH.unshift(__dir__) unless $LOAD_PATH.include?(__dir__)

require "config/logger"

Dir["lib/**/*.rb"].each { |file| require file }

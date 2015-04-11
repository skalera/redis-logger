require 'logger'
require 'redis'

class Redis
  # Log device to log to a redis instance
  class Logger < ::Logger::LogDevice
    def initialize(log, options = {})
      @log = log
      @pubsub = options.delete(:pubsub)
      @redis = Redis.new( options)
    end

    def write(message)
      if @pubsub
        @redis.publish(@log, message)
      else
        @redis.rpush(@log, message)
      end
    end

    def close
      @redis.disconnect!
    end
  end
end

require 'redis/logger/version'

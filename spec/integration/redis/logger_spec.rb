require 'spec_helper'

require 'securerandom'

describe Redis::Logger do
  before(:all) do
    # start a local redis
    @redis = Redis.new
    @redis.time # make sure we have a connection
  end

  after(:all) do
    # stop redis
  end

  describe 'with pubsub' do
    it 'should log to redis' do
      queue = SecureRandom.hex(16)
      logger = Logger.new(described_class.new(queue, pubsub: true))

      message = SecureRandom.hex(16)

      @redis.subscribe(queue) do |on|
        on.subscribe do |channel, _|
          expect(channel).to eq(queue)
          logger.warn(message)
        end

        on.message do |channel, msg|
          expect(channel).to eq(queue)
          expect(msg).to match(/WARN -- : #{message}/)
          @redis.unsubscribe(queue)
        end
      end
    end
  end

  describe 'with a queue' do
    it 'should log to redis' do
      queue = SecureRandom.hex(16)
      logger = Logger.new(described_class.new(queue))

      message = SecureRandom.hex(16)
      logger.info(message)
      puts 'done'

      expect(@redis.lpop(queue)).to match(/INFO -- : #{message}/)
    end
  end
end

require 'spec_helper'

describe Redis::Logger do
  it 'has a version number' do
    expect(Redis::Logger::VERSION).not_to be nil
  end

  describe '#new' do
    let(:redis) { double(Redis) }

    it 'should create an logger instance' do
      expect(Redis).to receive(:new).and_return(redis)
      expect(described_class.new('log')).to_not be_nil
    end
  end

  describe '#write' do
    let(:redis) { double(Redis) }

    describe 'with queue' do
      let(:subject) { described_class.new('log') }

      it 'appends to a list' do
        expect(Redis).to receive(:new).and_return(redis)
        expect(redis).to receive(:rpush).with('log', 'message')

        subject.write('message')
      end
    end

    describe 'with pubsub' do
      let(:subject) { described_class.new('log', pubsub: true) }

      it 'publishes the message' do
        expect(Redis).to receive(:new).and_return(redis)
        expect(redis).to receive(:publish).with('log', 'message')

        subject.write('message')
      end
    end
  end
end

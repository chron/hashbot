module Hashbot
  class Bot < SlackRubyBot::Bot
    help do
      title 'Hashbot'
      desc 'Hashbang Robot™'

      command 'test' do
        desc 'Test command.'
      end
    end
  end
end

SlackRubyBot.configure do |config|
  config.send_gifs = false
end

module Hashbot
  module Commands
    class Test < SlackRubyBot::Commands::Base
      command 'test' do |client, data, _match|
        Challenge.create(created_at: Time.now)
        client.say(channel: data.channel, text: 'test *formatting* :simple_smile:')
      end
    end
  end
end

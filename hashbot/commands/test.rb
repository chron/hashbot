module Hashbot
  module Commands
    class Test < SlackRubyBot::Commands::Base
      command 'test' do |client, data, _match|
        u = User.first_or_create(slug: data.user)

        client.say(channel: data.channel, text: u.inspect)
      end
    end
  end
end

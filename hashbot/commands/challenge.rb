module Hashbot
  module Commands
    class Challenge < SlackRubyBot::Commands::Base
      command 'challenge' do |client, data, match|
        if match['expression'].nil?
          client.say(channel: data.channel, text: "Usage: challenge `<desired result>`")
        else
          c = ::Challenge.create(
            created_at: Time.now,
            result: match['expression']
          )

          client.say(channel: data.channel, text: "Your new challenge has been created!")
          # TODO: notify channel
        end
      end
    end
  end
end

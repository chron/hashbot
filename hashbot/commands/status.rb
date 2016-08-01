module Hashbot
  module Commands
    class Status < SlackRubyBot::Commands::Base
      command 'status' do |client, data, match|
        u = User[data.user]
        c = Challenge.current

        client.say(channel: data.channel, text: "The current challenge is to produce this string in as few characters as possible:\n```\n#{c.result}\n```\nTry `hashbot leaderboard` to see the current high scores.")
      end
    end
  end
end

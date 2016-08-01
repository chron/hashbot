module Hashbot
  module Commands
    class Leaderboard < SlackRubyBot::Commands::Base
      command 'leaderboard' do |client, data, match|
        c = Challenge.current
        challenge_age = Time.now - c.created_at
        leaderboard_text = c.leaderboard.map { |u,s| '%3i %s' % [s,u.slug] } * ?\n

        client.say(channel: data.channel, text: "The challenge has been running for %i:%02i.  Current leaderboard:\n\n```%s```" % [
          challenge_age / 60,
          challenge_age % 60,
          leaderboard_text
        ])
      end
    end
  end
end

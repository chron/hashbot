module Hashbot
  module Commands
    class Show < SlackRubyBot::Commands::Base
      command 'show' do |client, data, match|
        u = User[data.user]
        c = Challenge.current
        s = u.best_submission_for(c)

        if s
          client.say(channel: data.channel, text: "Your best submission for the current challenge is `#{s.value.length}` characters long:\n```\n#{s.value}\n```")
        else
          client.say(channel: data.channel, text: "You haven't made any submissions for the current challenge.")
        end
      end
    end
  end
end

module Hashbot
  module Commands
    class ChallengeCommand < SlackRubyBot::Commands::Base
      command 'challenge' do |client, data, match|
        if match['expression'].nil?
          client.say(channel: data.channel, text: "Usage: challenge `<desired result>`")
        else
          c = Challenge.new(
            created_at: Time.now,
            result: match['expression']
          )

          begin
            c.desired_result
            c.save
            client.say(channel: data.channel, text: "Your new challenge has been created!")
            # TODO: notify channel
          rescue CodeEvalException => cee
            client.say(channel: data.channel, text: ":dizzy_face: #{cee.message}\nYour code:\n```\n#{cee.code.inspect}\n```\nOutput:\n```\n#{cee.inner_exception.message}\n```")
          end
        end
      end
    end
  end
end

module Hashbot
  module Commands
    class ChallengeCommand < SlackRubyBot::Commands::Base
      command 'challenge' do |client, data, match|
        announce_channel = client.channels.find { |k,h| h.name == Setting['announce_channel'] }.first

        if match['expression'].nil?
          client.say(channel: data.channel, text: "Usage: challenge `<desired result>`")
        else
          old_challenge = Challenge.current
          c = Challenge.new(
            created_at: Time.now,
            result: match['expression']
          )

          begin
            c.desired_result
            c.save

            if old_challenge
              winning_submission = old_challenge.best_submission

              if winning_submission
                u = winning_submission.user
                client.say(channel: announce_channel, text: "A challenge has ended. #{u.name} was the winner with a score of #{winning_submission.score}.  *Congratulations!* :trophy:\nWinning code: `#{winning_submission.value}`")
              end
            end

            client.say(channel: data.channel, text: "Your new challenge has been created!")
            client.say(channel: announce_channel, text: ":sports_medal: *A new challenge has been begun!* :sports_medal:\nTarget expression: `#{c.result}`")
          rescue CodeEvalException => cee
            client.say(channel: data.channel, text: ":dizzy_face: #{cee.message}\nYour code:\n```\n#{cee.code.inspect}\n```\nOutput:\n```\n#{cee.inner_exception.message}\n```")
          end
        end
      end
    end
  end
end

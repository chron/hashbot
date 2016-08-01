module Hashbot
  module Commands
    class Submit < SlackRubyBot::Commands::Base
      command 'submit' do |client, data, match|
        if match['expression'].nil?
          client.say(channel: data.channel, text: "Usage: submit `<your code here>`")
        else
          u = User[data.user, client.users]
          c = Challenge.current

          begin
            high_score = c.best_score
            my_previous_best_score = u.best_score_for(c)
            announce_channel = client.channels.find { |k,h| h.name == Setting['announce_channel'] }.first

            s = Submission.create(user: u, challenge: c, value: match['expression'])
            new_score = s.calculate_score!

            if new_score.nil?
              client.say(channel: data.channel, text: ":fearful: Your code did not produce valid output for the challenge.  Try again!\nCode: `#{s.value}`\nExpected result: `#{c.desired_result}`\nActual result: `#{s.actual_result}`")
            elsif high_score.nil?
              client.say(channel: data.channel, text: "Your score for that submission was *#{s.score}*.  That's the first valid submission for this challenge, so you are currently in the lead! :facepunch:")
              client.say(channel: announce_channel, text: "#{u.name} has started us off with a *#{s.score}* character solution.  Try to beat it!")
            elsif new_score < high_score
              client.say(channel: data.channel, text: "Your score for that submission was *#{s.score}*.  That's a new high score for this challenge!  You've beaten the previous record of *#{high_score}*. :facepunch:")
              client.say(channel: announce_channel, text: "#{u.name} has submitted a solution with *#{s.score}* characters - a *#{high_score - s.score}* character improvement - and is now in the lead! :sports_medal:")
            elsif my_previous_best_score.nil?
              client.say(channel: data.channel, text: "Your score for that submission was *#{s.score}*.  Good start!  The current high score for this challenge is *#{high_score}*.")
            elsif new_score < my_previous_best_score
              client.say(channel: data.channel, text: "Your score for that submission was *#{s.score}*.  That's a new personal best for this challenge!  Your previous high score was *#{my_previous_best_score}*. :ok_hand:")
            elsif new_score == my_previous_best_score
              client.say(channel: data.channel, text: "Your score for that submission was *#{s.score}*.  That's exactly the same as your current best.  Keep trying!")
            else
              client.say(channel: data.channel, text: "Your score for that submission was *#{s.score}*.  Unfortunately it's not an improvement on your previous best of *#{my_previous_best_score}*!")
            end
          rescue CodeEvalException => cee
            client.say(channel: data.channel, text: ":dizzy_face: #{cee.message}\nYour code:\n```\n#{cee.code}\n```\nOutput:\n```\n#{cee.inner_exception.message}\n```")
          end
        end
      end
    end
  end
end

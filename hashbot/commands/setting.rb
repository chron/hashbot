module Hashbot
  module Commands
    class SettingCommand < SlackRubyBot::Commands::Base
      command 'setting' do |client, data, match|
        setting, value = match['expression'].try(:split)

        if setting.nil?
          setting_table = Setting.all.map { |s| '%20s => %s' % [s.setting, s.value] } * ?\n
          if setting_table == ''
            client.say(channel: data.channel, text: "No settings defined yet.")
          else
            client.say(channel: data.channel, text: "All Hashbot settings: \n```#{setting_table}```")
          end
        elsif value.nil?
          current_value = Setting[setting]
          if current_value && current_value != ''
            client.say(channel: data.channel, text: "The current value for `#{setting}` is `#{}`")
          else
            client.say(channel: data.channel, text: "There is no setting called `#{setting}` at the moment.")
          end
        else
          Setting[setting] = value
          client.say(channel: data.channel, text: "The value for `#{setting}` has been updated to `#{value}`")
        end
      end
    end
  end
end

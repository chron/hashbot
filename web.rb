require 'sinatra/base'

module Hashbot
  class Web < Sinatra::Base
    get '/' do
      @title = 'Leaderboard'
      @challenge = Challenge.current
      haml :index
    end
  end
end

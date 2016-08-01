require 'sinatra/base'

module Hashbot
  class Web < Sinatra::Base
    get '/' do
      @challenge = Challenge.current
      haml :index
    end
  end
end

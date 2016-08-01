require 'sinatra/base'

module Hashbot
  class Web < Sinatra::Base
    get '/' do
      haml :index
    end
  end
end

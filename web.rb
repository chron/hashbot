require 'sinatra/base'

module Hashbot
  class Web < Sinatra::Base
    get '/' do
      'Welcome to me.'
    end
  end
end

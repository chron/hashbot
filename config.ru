$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'require_all'

require 'dotenv'
Dotenv.load

require 'data_mapper'
require_all 'models'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/hashbot')
DataMapper.finalize.auto_upgrade!

require 'hashbot'
require 'web'

Thread.abort_on_exception = true

Thread.new do
  begin
    Hashbot::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run Hashbot::Web

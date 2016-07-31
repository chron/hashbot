class Challenge
  include DataMapper::Resource
  
  property :id, Serial
  property :created_at, DateTime
end

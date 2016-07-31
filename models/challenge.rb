class Challenge
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :description, Text, lazy: false
  property :result, Text, lazy: false

  #has 1, :user
  has n, :submissions

  def best_score
    submissions.max(:score)
  end
end

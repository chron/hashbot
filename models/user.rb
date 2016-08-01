class User
  include DataMapper::Resource

  property :id, Serial
  property :slug, String
  property :name, String

  has n, :submissions

  def best_score_for(challenge)
    submissions.all(challenge: challenge).min(:score)
  end
end

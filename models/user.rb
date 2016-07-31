class User
  include DataMapper::Resource

  property :slug, String, key: true

  has n, :submissions

  def best_score_for(challenge)
    submissions.all(challenge: challenge).min(:score)
  end
end

class User
  include DataMapper::Resource

  property :id, Serial
  property :slug, String
  property :name, String

  has n, :submissions

  def best_score_for(challenge)
    submissions.all(challenge: challenge).min(:score)
  end

  # Returns user's submission with the best score.  If there's a tie, it will
  # return the most recent.
  def best_submission_for(challenge)
    submissions.all(challenge: challenge, score: best_score_for(challenge)).first(order: :created_at.desc)
  end

  def self.[](slug, users=nil)
    u = first_or_create(slug: slug)

    if users
      u.name = users[slug].try(:name)
      u.save # CHECK: does this hit the DB even if nothing has changed?
    end

    u
  end
end

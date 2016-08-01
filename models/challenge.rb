class Challenge
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :description, Text, lazy: false
  property :result, Text, lazy: false

  has n, :submissions

  # Returns the best (lowest!) score for this challenge so far.
  def best_score
    submissions.min(:score)
  end

  # This value is compared to eval'd submissions to determine validity.
  def desired_result
    CodeEvaluator.evaluate(result)
  end

  # Returns a list of users with scores, ordered with the best score first.
  def leaderboard
    leaderboard = submissions.aggregate(:user_id, :score.max)
    # TODO: there's probably a smart way to do this in DM
    leaderboard.map { |uid,score| [User.get(uid), score] }.sort_by { |uid,score| score }
  end

  # Returns the active challenge - at the moment just the most recent one.
  def self.current
    first(order: :created_at.desc)
  end
end

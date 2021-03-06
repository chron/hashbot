class Submission
  include DataMapper::Resource

  property :id, Serial
  property :value, Text, lazy: false
  property :created_at, DateTime
  property :score, Integer

  belongs_to :user
  belongs_to :challenge

  def value_is_valid?
    actual_result == challenge.desired_result
  end

  def actual_result
    CodeEvaluator.evaluate(value)
  end

  def calculate_score!
    if value_is_valid?
      self.score = value.length
      save
    end

    self.score
  end
end

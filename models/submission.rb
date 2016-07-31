class Submission
  include DataMapper::Resource

  property :id, Serial
  property :value, Text, lazy: false
  property :created_at, DateTime
  property :score, Integer

  belongs_to :user
  belongs_to :challenge

  def value_is_valid?
    # TODO: $SAFE etc, obviously this is the world's biggest security flaw
    begin
      eval(value) == eval(challenge.result)
    rescue Exception => e
      raise CodeEvalException.new(value, e), "There was an error evaluating the code."
    end
  end

  def calculate_score!
    if value_is_valid?
      self.score = value.length
      save
    end

    self.score
  end
end

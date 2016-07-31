class CodeEvaluator
  def self.evaluate(code_string)
    # TODO: $SAFE etc, obviously this is the world's biggest security flaw

    code_string.gsub!(/[”“]/, '"')
    code_string.gsub!(/[‘’]/, "'")

    begin
      eval(code_string)
    rescue Exception => e
      raise CodeEvalException.new(code_string, e), "There was an error evaluating the code."
    end
  end
end

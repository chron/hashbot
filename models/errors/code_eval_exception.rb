class CodeEvalException < Exception
  attr_reader :code, :inner_exception

  def initialize(code, inner_exception)
    @code, @inner_exception = code, inner_exception
  end
end

class Solution
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def strategies
    ObjectSpace.each_object(Class).select { |klass| klass < Strategy }
  end

  def results
    strategies.map do |strategy|
      "#{strategy.name}: #{strategy.new(input).result}"
    end
  end

  class Strategy
    attr_reader :input

    def initialize(input)
      @input = input
    end
  end
end

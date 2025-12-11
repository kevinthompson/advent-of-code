require_relative('../../lib/support')

EXAMPLE_RESULT = 3263827

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    data = input.split("\n").map(&:chars).transpose.map(&:join).join("\n").gsub(' ', '').split("\n\n")
    data.sum do |str, i|
      values = str.split
      operator = values[0][-1]
      numbers = values.map { |v| v[/\d+/] }.map(&:to_i)
      numbers.reduce(&operator.to_sym)
    end
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end

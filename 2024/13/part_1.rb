require_relative('../../lib/support')
require 'matrix'

EXAMPLE_RESULT = 480

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end
  
  def result
    input.split("\n\n").sum do |machine|
      a, b, prize = machine.split("\n").map do |str|
        str.scan(/\d+/).map(&:to_i)
      end

      y = (a[0] * prize[1] - a[1] * prize[0]) / ((a[0] * b[1]) - (a[1] * b[0]))
      x = (prize[0] - b[0] * y) / a[0]
      prize[1] == a[1] * x + b[1] * y ? x * 3 + y : 0
    end
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end

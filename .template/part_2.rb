require_relative('../../lib/support')

EXAMPLE_RESULT = nil

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def call
    # TODO: implement solution
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).call
end

require_relative('../../lib/support')

EXAMPLE_RESULT = 4174379265

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    answer = 0

    input.split(',').each do |range|
      first, last = range.split('-').map(&:to_i)
      (first..last).each do |i|
        answer += i if i.to_s[/^(\d+)\1+$/]
      end
    end

    answer
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end

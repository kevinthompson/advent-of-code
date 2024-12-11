require_relative('../../lib/support')

class Solution
  attr_reader :input, :blink_count, :scores

  def initialize(input:, blink_count: 25)
    @input = input
    @blink_count = blink_count
    @scores = {}
  end

  def score(stone, blinks)
    return 1 if blinks.zero?
    next_blinks = blinks - 1

    scores[[stone, blinks]] ||= if stone == '0'
      score('1', next_blinks)
    elsif stone.size.even?
      first_half = stone[0...stone.size/2]
      second_half = stone[stone.size/2..-1].to_i.to_s
      score(first_half, next_blinks) + score(second_half, next_blinks)
    else
      score((stone.to_i * 2024).to_s, next_blinks)
    end
  end

  def call
    input.split(' ').sum(0) do |stone|
      score(stone, blink_count)
    end
  end
end

solve do |input|
  Solution.new(input:, blink_count: 75).call
end

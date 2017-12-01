require_relative '../../../lib/solution'

class Solution
  class PartTwo < Strategy
    def result
      input.chars.each_with_index.reduce(0) do |sum, (char, index)|
        sum += input[index - (input.length / 2)] == char ? char.to_i : 0
      end
    end
  end
end

require_relative '../../../lib/solution'

class Solution
  class PartOne < Strategy
    def result
      input.chars.each_with_index.reduce(0) do |sum, (char, index)|
        sum += char == input[index - 1] ? char.to_i : 0
      end
    end
  end
end

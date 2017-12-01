input = File.open('./input.txt').read.strip

class RecursiveString < String
  def [](i)
    if i >= length
      super(i - length)
    else
      super(i)
    end
  end
end

module Solution
  class Strategy
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def values
      []
    end

    def result
      values.map(&:to_i).inject(0, :+)
    end
  end

  class PartOne < Strategy
    def values
      string = input + input[0]
      string.scan(/(\d)(?=\1)/).flatten
    end
  end

  class PartTwo < Strategy
    def values
      string = RecursiveString.new(input)
      step = string.length / 2
      chars = string.chars
      chars.each_with_index.map { |c, i| c == string[i + step] ? c : nil }
    end
  end
end

p "Part One: #{Solution::PartOne.new(input).result}"
p "Part Two: #{Solution::PartTwo.new(input).result}"

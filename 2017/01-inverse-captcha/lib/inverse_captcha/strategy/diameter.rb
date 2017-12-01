require_relative 'base'

class InverseCaptcha
  module Strategy
    class Diameter < Base
      def result
        offset = input.length / 2
        input.chars.each_with_index.reduce(0) do |sum, (char, index)|
          sum += input[index - offset] == char ? char.to_i : 0
        end
      end
    end
  end
end

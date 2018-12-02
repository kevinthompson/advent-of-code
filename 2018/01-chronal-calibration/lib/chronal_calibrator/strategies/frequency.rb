class ChronalCalibrator
  module Strategies
    class Frequency < Base
      def result
        i = 0
        result = nil
        frequency = 0
        frequencies = []

        while result.nil? do
          frequency += values[i]
          result = frequency if frequencies.include?(frequency)
          i += 1
          i = 0 if i >= values.length
          frequencies << frequency
        end

        result
      end
    end
  end
end

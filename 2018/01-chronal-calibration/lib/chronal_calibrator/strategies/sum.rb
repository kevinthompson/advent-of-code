class ChronalCalibrator
  module Strategies
    class Sum < Base
      def result
        values.inject(:+)
      end
    end
  end
end

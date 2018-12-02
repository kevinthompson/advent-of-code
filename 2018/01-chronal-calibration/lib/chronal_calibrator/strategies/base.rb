class ChronalCalibrator
  module Strategies
    class Base
      attr_reader :values

      def initialize(values:)
        @values = values
      end
    end
  end
end

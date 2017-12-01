class InverseCaptcha
  module Strategy
    class Base
      attr_reader :input

      def initialize(input)
        @input = input
      end
    end
  end
end

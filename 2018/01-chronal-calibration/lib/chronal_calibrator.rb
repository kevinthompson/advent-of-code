require_relative "chronal_calibrator/command"
require_relative "chronal_calibrator/strategies/base"
require_relative "chronal_calibrator/strategies/frequency"
require_relative "chronal_calibrator/strategies/sum"

class ChronalCalibrator
  def initialize(strategy: :sum, values:)
    @strategy = strategy
    @values = values
  end

  def result
    if strategy_class
      print "Calculating result using the #{strategy} strategy...\n"
      print "Result: "
      print strategy_class.new(values: values).result
    else
      print "! The #{strategy} strategy is not defined."
    end
  end

  private

  attr_reader :values, :strategy

  def strategy_class
    if Strategies.const_defined?(strategy_class_name)
      Strategies.const_get(strategy_class_name)
    end
  end

  def strategy_class_name
    strategy.to_s.split('_').collect(&:capitalize).join
  end
end

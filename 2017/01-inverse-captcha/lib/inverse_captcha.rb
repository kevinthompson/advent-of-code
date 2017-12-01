require_relative 'inverse_captcha/strategy/siblings'
require_relative 'inverse_captcha/strategy/diameter'

class InverseCaptcha
  attr_reader :input
  attr_accessor :strategy

  def initialize(input:, strategy: nil)
    @input = input
    @strategy = strategy
  end

  def result
    return nil if strategy.nil?
    strategy.new(input).result
  end
end

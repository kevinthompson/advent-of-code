require 'minitest/autorun'
require_relative '../../../lib/inverse_captcha/strategy/diameter'

class TestDiameter < Minitest::Test
  def test_result
    assert_equal 6, InverseCaptcha::Strategy::Diameter.new('1212').result
    assert_equal 0, InverseCaptcha::Strategy::Diameter.new('1221').result
    assert_equal 12, InverseCaptcha::Strategy::Diameter.new('123123').result
    assert_equal 4, InverseCaptcha::Strategy::Diameter.new('12131415').result
  end
end

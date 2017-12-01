require 'minitest/autorun'
require_relative '../../../lib/inverse_captcha/strategy/siblings'

class TestSiblings < Minitest::Test
  def test_result
    assert_equal 3, InverseCaptcha::Strategy::Siblings.new('1122').result
    assert_equal 4, InverseCaptcha::Strategy::Siblings.new('1111').result
    assert_equal 0, InverseCaptcha::Strategy::Siblings.new('1234').result
    assert_equal 9, InverseCaptcha::Strategy::Siblings.new('91212129').result
  end
end

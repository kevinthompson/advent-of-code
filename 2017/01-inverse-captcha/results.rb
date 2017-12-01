require_relative 'lib/inverse_captcha'

input = File.open(File.join(File.dirname(__FILE__), 'input.txt')).read.strip
captcha = InverseCaptcha.new(input: input)

captcha.strategy = InverseCaptcha::Strategy::Siblings
print "Siblings Strategy: #{captcha.result}\n"

captcha.strategy = InverseCaptcha::Strategy::Diameter
print "Diameter Strategy: #{captcha.result}\n"

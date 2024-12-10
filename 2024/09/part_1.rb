require_relative('../../lib/support')

solve example: 1928 do |input|
  blocks = []

  input.chomp.each_char.with_index do |char, index|
    blocks += Array.new(char.to_i, index.even? ? index / 2 : '.')
  end

  result = 0
  blocks.each_with_index do |char, index|
    if char == '.'
      number = 0
      number = blocks.pop.to_i while blocks.length > index && number.zero?
      result += number.to_i * index
    else
      result += char.to_i * index
    end
  end

  result
end

require_relative('../../lib/support')

solve example: 55312 do |input|
  stones = input.split(' ').map(&:to_i)

  25.times do
    stones = stones.flat_map do |stone|
      if stone == 0
        1
      elsif stone.to_s.size.even?
        string = stone.to_s
        [string[0...string.size/2].to_i, string[string.size/2..-1].to_i]
      else
        stone * 2024
      end
    end
  end

  stones.count
end

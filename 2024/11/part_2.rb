require_relative('../../lib/support')

solve do |input|
  stones = input.split(' ').map(&:to_i)
  blink_count = 25
  blink_count.times do
    stones = stones.flat_map do |stone|
      if stone == 0
        1
      elsif stone.to_s.size.even?
        string = stone.to_s
        [string[0...string.size/2].to_i, string[string.size/2..-1].to_i]
      else
        (stone << 10) - (stone << 5) - (stone << 3)
      end
    end
  end

  stones.count
end

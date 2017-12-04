require 'minitest/autorun'

input = File.open('input.txt').read.strip.to_i

def distance(i)
  center_x, center_y = position(1)
  target_x, target_y = position(i)
  (center_x - target_x).abs + (center_y - target_y).abs
end

def next_value(i)
  data = []
  sum = 1
  index = 1
  until sum > i
    coords = position(index)
    new_sum = sum_adjacent_squares(index, coords, data)
    sum = new_sum unless new_sum.nil?
    data << { point: index, coords: coords, value: sum }
    index += 1
  end

  sum
end

def sum_adjacent_squares(point, coords, data)
  adjacent_squares(coords).
    map { |coords| data.find { |item| item[:coords] == coords } }.
    compact.
    map { |item| item[:value] }.
    reduce(&:+)
end

def adjacent_squares(coords)
  x, y = coords
  [
    [x, y + 1],
    [x + 1, y + 1],
    [x + 1, y],
    [x + 1, y - 1],
    [x, y - 1],
    [x - 1, y - 1],
    [x - 1, y],
    [x - 1, y + 1],
  ]
end

def position(n)
  k=((Math.sqrt(n)-1)/2).ceil
  t=2*k+1
  m=t**2
  t=t-1
  if n>=m-t then return [k-(m-n),-k] else m=m-t end
  if n>=m-t then return [-k,-k+(m-n)] else m=m-t end
  if n>=m-t then return [-k+(m-n),k] else return [k,k-(m-n-t)] end
end

class TestSolution < Minitest::Test
  def test_distance
    assert_equal 0, distance(1)
    assert_equal 3, distance(12)
    assert_equal 2, distance(23)
    assert_equal 31, distance(1024)
  end
end

print "Distance for #{input}: #{distance(input)}\n"
print "Next Value for #{input}: #{next_value(input)}\n\n"

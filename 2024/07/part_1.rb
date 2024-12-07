require_relative('../../lib/support')

solve example: 3749 do |input|
  operations = [:*, :+]

  input.lines.flat_map do |line|
    total, number_string = line.split(': ')
    total = total.to_i
    numbers = number_string.split(' ').map(&:to_i)

    permutations = operations.repeated_permutation(numbers.size - 1)
    total if permutations.any? do |permutation|
      result = numbers[0]
      (1...numbers.size).each do |index|
        result = result.send(permutation[index - 1], numbers[index])
      end
      result == total
    end
  end.compact.sum
end

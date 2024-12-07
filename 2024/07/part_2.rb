require_relative('../../lib/support')

solve example: 11387 do |input|
  operations = [:*, :+, :concat]

  input.lines.flat_map do |line|
    total, number_string = line.split(': ')
    total = total.to_i
    numbers = number_string.split(' ').map(&:to_i)

    permutations = operations.repeated_permutation(numbers.size - 1)
    total if permutations.any? do |permutation|
      result = numbers[0]
      (1...numbers.size).each do |index|
        operation = permutation[index - 1]
        number = numbers[index]

        case operation
        when :+
          result += number
        when :*
          result *= number
        when :concat
          result = (result.to_s + number.to_s).to_i
        end
      end

      result == total
    end
  end.compact.sum
end

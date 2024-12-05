require_relative('../../lib/support')

solve example: 123 do |input|
  result = 0
  rule_string, update_string = input.split("\n\n")
  rules = rule_string.split("\n").map { |rule| rule.split("|").map(&:to_i) }.sort
  updates = update_string.split("\n").map { |update| update.split(',').map(&:to_i) }

  updates.each do |update|
    valid = true

    rules.each do |rule|
      a, b = rule
      index_a = update.find_index(a)
      index_b = update.find_index(b)

      if !index_a.nil? && !index_b.nil? && index_a > index_b
        valid = false
        value = update.delete_at(index_a)
        update.insert(index_b, value)
      end
    end

    if !valid
      result += update[(update.size/2).floor]
    end
  end

  result
end

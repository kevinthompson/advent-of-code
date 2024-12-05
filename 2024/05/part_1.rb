require_relative('../../lib/support')

solve example: 143 do |input|
  result = 0
  rule_string, update_string = input.split("\n\n")
  rules = rule_string.split("\n").map { |rule| rule.split("|").map(&:to_i) }
  updates = update_string.split("\n").map { |update| update.split(',').map(&:to_i) }

  updates.each do |update|
    result += update[(update.size/2).floor] if rules.all? do |rule|
      !update.include?(rule[0]) ||
        !update.include?(rule[1]) ||
        update.find_index(rule[0]) < update.find_index(rule[1])
    end
  end

  result
end

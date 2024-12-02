input = File.read(File.join(__dir__, 'input'))
lists = input.split("\n").map(&:split).transpose.map(&:sort)
occurrences = lists[1].tally

print lists[0].reduce(0) { |memo, a|
  memo + a.to_i * occurrences[a].to_i
}

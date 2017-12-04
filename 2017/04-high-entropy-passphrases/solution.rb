input = File.open('input.txt').read.strip
count_1 = input.lines.count { |line| line[/\b(\w+)\b.*\1/].nil? }
count_2 = input.lines.map(&:strip).count do |phrase|
  unique = phrase.split(' ').map { |w| w.chars.sort.join }.uniq.join(' ')
  unique.length == phrase.length
end

p count_1
p count_2

File.read(File.join(__dir__, 'input.txt'))
    .split("\n")
    .map(&:split)
    .count do |report|
      operator = nil
      (1...report.size).all? do |i|
        a = report[i - 1].to_i
        b = report[i].to_i
        diff = (a - b).abs
        operator ||= a > b ? :> : :<
        a.send(operator, b) && diff >= 1 && diff <= 3
      end
    end.tap do |n|
      puts n
    end

class IncorrectSolution < StandardError
  def message
    'Result does not match expected answer.'
  end
end

def solve(example_answer:)
  dir = File.dirname(caller_locations.first.path)
  raise IncorrectSolution unless yield(File.read("#{dir}/example.txt")) == example_answer

  puts yield(File.read("#{dir}/input.txt"))
end

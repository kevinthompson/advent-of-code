input_path = "input"
result = 1
input = {}

for line in io.lines(input_path) do
  local numbers = {}
  for number in line:gmatch("(%d+)") do
    table.insert(numbers,tonumber(number))
  end
  table.insert(input, numbers)
end

function record_distances(time, record)
  count = 0

  for i = 0, time do
    local duration = time - i
    local distance = i * duration

    if distance > record then
      count = count + 1
    end
  end

  return count
end

for i, time in ipairs(input[1]) do
  result = result * record_distances(time, input[2][i])
end

-- Expected for sample: 288
print("Result: " .. tostring(result))

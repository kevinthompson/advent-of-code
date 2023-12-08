input_path = "input"
input = {}

for line in io.lines(input_path) do
  local number = ""
  for part in line:gmatch("(%d+)") do
    number = number .. part
  end
  table.insert(input, tonumber(number))
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

result = record_distances(input[1], input[2])

-- Expected for sample: 288
print("Result: " .. tostring(result))

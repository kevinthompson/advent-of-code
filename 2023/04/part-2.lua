input_path = "input"
sum = 0
matches = {}

function increment_sum(i)
  sum = sum + 1

  for j = i + 1, i + matches[i] do
    increment_sum(j)
  end
end

for line in io.lines(input_path) do
  local line = line:gsub("Card%s+%d+: ","")
  local div = line:find("|")
  local wins = {}
  local picks = {}

  for i, number in line:gmatch("()(%d+)") do
    local group = i < div and wins or picks
    group[number] = true
  end

  local count = 0
  for number, _ in pairs(picks) do
    if wins[number] then
      count = count + 1
    end
  end

  table.insert(matches, count)
end

for i=1, #matches do
  increment_sum(i)
end

-- Expected for sample: 30
print("Result: " .. sum)

input_path = "input"
sum = 0

lines = {}
for line in io.lines(input_path) do
  local line = line:gsub("Card%s+%d+: ","")
  local div = line:find("|")
  local wins = {}
  local picks = {}

  for i, number in line:gmatch("()(%d+)") do
    local group = i < div and wins or picks
    group[number] = true
  end

  local match_count = 0
  for number, _ in pairs(picks) do
    if wins[number] then
      match_count = match_count + 1
    end
  end

  sum = sum + math.floor(2^(match_count - 1))
end

-- Expected for sample: 13
print("Result: " .. sum)

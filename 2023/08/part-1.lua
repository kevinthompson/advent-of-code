input_path = "input"
result = nil
pattern = nil
directions = {}

i = 1
for line in io.lines(input_path) do
  if i == 1 then
    pattern = line:match("%u+")
  elseif i > 2 then
    local key = nil
    for str in line:gmatch("(%u+)") do
      if not key then
        key = str
        directions[key] = {}
      else
        table.insert(directions[key], str)
      end
    end
  end

  i = i + 1
end

key = "AAA"
steps = 0
while result == nil do
  for i = 1, #pattern do
    steps = steps + 1
    local dir = string.sub(pattern, i, i) == "L" and 1 or 2
    key = directions[key][dir]

    if key == "ZZZ" then
      result = steps
      break
    end
  end
end

-- Expected for sample: 6440
print("Result: " .. tostring(result))

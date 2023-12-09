input_path = "input"
pattern = nil
directions = {}

i = 1
for line in io.lines(input_path) do
  if i == 1 then
    pattern = line:match("[%d%u]+")
  elseif i > 2 then
    local key = nil
    for str in line:gmatch("([%d%u]+)") do
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

keys = {}
for k,_ in pairs(directions) do
  if string.sub(k,3,3) == "A" then
    table.insert(keys,k)
  end
end

results = {}

for _, key in ipairs(keys) do
  local steps = 0
  local result = nil

  while result == nil do
    for i = 1, #pattern do
      steps = steps + 1
      local dir = string.sub(pattern, i, i) == "L" and 1 or 2
      key = directions[key][dir]

      if string.sub(key,3,3) == "Z" then
        result = steps
        break
      end
    end
  end

  table.insert(results, result)
end

function gcd(a, b)
  if b == 0 then
    return a
  end

  return gcd(b, a % b)
end

answer = results[1]
for i = 2, #results do
  answer = math.floor((results[i] * answer) / gcd(results[i], answer))
end

-- Expected for sample: 6
print("Answer: " .. answer)

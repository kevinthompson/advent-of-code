input_path = "input"
sum = 0

lines = {}
for line in io.lines(input_path) do
  table.insert(lines,line)
end

function symbol_in_range(str,i,j)
  if str == nil then
    return false
  end

  for si,symbol in str:gmatch("()([^%d%.])") do
    if si >= i and si <= j then
      return true
    end
  end

  return false
end

for index,line in ipairs(lines) do
  for i,numeric,j in line:gmatch("()(%d+)()") do
    if symbol_in_range(lines[index - 1], i-1, j)
    or symbol_in_range(line, i-1, j)
    or symbol_in_range(lines[index + 1], i-1, j) then
      sum = sum + tonumber(numeric)
    end
  end
end

-- Expected for sample: 4361
print("Result: " .. sum)

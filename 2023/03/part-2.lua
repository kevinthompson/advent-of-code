input_path = "input"
sum = 0

lines = {}
for line in io.lines(input_path) do
  table.insert(lines,line)
end

function add_numbers_from_line(numbers,str,index)
  if str == nil then
    return
  end

  for i, numeric, j in str:gmatch("()(%d+)()") do
    if i <= index + 1 and j-1 >= index - 1 then
      table.insert(numbers,tonumber(numeric))
    end
  end
end

for index,line in ipairs(lines) do
  for i,_ in line:gmatch("()(%*)") do
    numbers = {}
    add_numbers_from_line(numbers, lines[index - 1], i)
    add_numbers_from_line(numbers, line, i)
    add_numbers_from_line(numbers, lines[index + 1], i)

    if #numbers == 2 then
      sum = sum + (numbers[1] * numbers[2])
    end
  end
end

-- Expected for sample: 4361
print("Result: " .. sum)

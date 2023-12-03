input_path = "input"
sum = 0

-- add_numbers_from_line
-- arguments:
--   * numbers: tables containing number matches
--   * str: a string to find numbers in
--   * index: index of a character to find numbers nearby
function add_numbers_from_line(numbers,str,index)
  if str == nil then
    return
  end

  -- for each number in the provided string, return:
  --   * i: the start index of the number
  --   * numeric: the match as a numeric string
  --   * j: the index following the number
  for i, numeric, j in str:gmatch("()(%d+)()") do

    -- add the number to the collection if both statements are true:
    --   * the start index is less than equal to the provided index + 1
    --   * the end index is greater than equal to the provided index - 1
    if i <= index + 1 and j-1 >= index - 1 then
      table.insert(numbers,tonumber(numeric))
    end
  end
end

-- Add all lines to a table (array)
lines = {}
for line in io.lines(input_path) do
  table.insert(lines,line)
end

-- For each line in lines table
for index,line in ipairs(lines) do

  -- find position of asterisk in line 
  for i in line:gmatch("()%*") do
    numbers = {}
    add_numbers_from_line(numbers, lines[index - 1], i) -- find numbers in previous line
    add_numbers_from_line(numbers, line, i)             -- find numbers in current line
    add_numbers_from_line(numbers, lines[index + 1], i) -- find numbers in next line

    -- if there are only two adjacent numbers, add the product of those numbers to the sum
    if #numbers == 2 then
      sum = sum + (numbers[1] * numbers[2])
    end
  end
end

-- Expected for sample: 4361
print("Result: " .. sum)

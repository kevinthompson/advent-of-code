input_path = "input"
numbers = {"one","two","three","four","five","six","seven","eight","nine","%d"}
sum = 0

for line in io.lines(input_path) do
  local first, last
  local startpos, endpos

  for index, number in ipairs(numbers) do
    for i, match, j in line:gmatch("()("..number..")()") do
      if match then
        local value = index > 9 and tonumber(match) or index

        if startpos == nil or i < startpos then
          startpos = i
          first = value
        end

        if endpos == nil or i > endpos then
          endpos = i
          last = value
        end
      end
    end
  end

  local line_value = tonumber(first..last)
  print(line_value)
  sum = sum + line_value
end

print(sum)

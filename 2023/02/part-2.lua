input_path = "input"
sum = 0

for line in io.lines(input_path) do
  local colors = {
    red = 0,
    green = 0,
    blue = 0
  }

  local game_number = tonumber(line:match("(%d+):"))
  local groups = line:gsub("Game " .. game_number, "") .. ";"

  for group in groups:gmatch("([%w%s,]+);") do
    for color, _ in pairs(colors) do
      local match = group:match("(%d+) " .. color)

      if match then
        local value = tonumber(match)
        if value > colors[color] then
          colors[color] = value
        end
      end
    end
  end

  local product = 1
  for color, count in pairs(colors) do
    product = product * count
  end

  sum = sum + product
end

print("Result: " .. sum)

-- Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green

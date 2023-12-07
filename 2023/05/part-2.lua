input_path = "input"
result = nil

maps = {}
seeds = {}
map_id = 0

for line in io.lines(input_path) do
  if line:find("seeds:") then
    for number in line:gmatch("(%d+)") do
      table.insert(seeds,tonumber(number))
    end
  else
    local _, _, name = line:find("(.*) map:")
    if name then
      map_id = map_id + 1
      maps[map_id] = {}
    elseif line:find("%d+") then
      local source = {}

      for number in line:gmatch("(%d+)") do
        table.insert(source, tonumber(number))
      end

      table.insert(maps[map_id], {
        source[2], source[2] + source[3] - 1, source[1] - source[2]
      })
    end
  end
end

ranges = {}
for i=1, #seeds, 2 do
  table.insert(ranges, { seeds[i], seeds[i] + seeds[i+1] - 1 })
end

for _, map in pairs(maps) do
  for _, adjustment in pairs(map) do
    for i = #ranges, 1, -1 do
      local range = table.remove(ranges, i)
      local new_ranges = {}

      if range[2] < adjustment[1] or range[1] > adjustment[2] or range[3] then
        table.insert(new_ranges, range)
      else
        low = range[1]
        high = range[2]

        if range[1] < adjustment[1] then
          before_adjustment = adjustment[1] - 1
          new_range_end = range[2] < before_adjustment and range[2] or before_adjustment
          table.insert(new_ranges, { range[1], new_range_end })
          low = new_range_end + 1
        end

        if range[2] > adjustment[2] then
          after_adjustment = adjustment[2] + 1
          new_range_start = range[1] > after_adjustment and range[1] or after_adjustment
          table.insert(new_ranges, { new_range_start, range[2] })
          high = new_range_start - 1
        end

        table.insert(new_ranges, {
          (low > adjustment[1] and low or adjustment[1]) + adjustment[3],
          (high < adjustment[2] and high or adjustment[2]) + adjustment[3],
          true
        })
      end

      for _, range in ipairs(new_ranges) do
        table.insert(ranges, range)
      end
    end
  end

  for _, range in pairs(ranges) do
    table.remove(range,3)
  end
end

for _,range in pairs(ranges) do
  if not result or result > range[1] then
    result = range[1]
  end
end

-- Expected for sample: 46
print("Result: " .. result)

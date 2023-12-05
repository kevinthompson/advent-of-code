input_path = "input"
result = nil

map_keys = {}
maps = {}
seeds = {}

for line in io.lines(input_path) do
  if line:find("seeds:") then
    for number in line:gmatch("(%d+)") do
      table.insert(seeds,tonumber(number))
    end
  else
    local _, _, name = line:find("(.*) map:")
    if name then
      maps[name] = {}
      table.insert(map_keys, name)
      map=name
    elseif line:find("%d+") then
      local entry = {}
      local key = map_keys[#map_keys]
      for number in line:gmatch("(%d+)") do
        table.insert(entry,tonumber(number))
      end
      table.insert(maps[key],entry)
    end
  end
end

for _,value in ipairs(seeds) do
  for _,key in ipairs(map_keys) do
    for _,entry in ipairs(maps[key]) do
      if value >= entry[2] and value <= entry[2] + entry[3] - 1 then
        value = value - entry[2] + entry[1]
        break
      end
    end
  end

  if not result or value < result then
    result = value
  end
end

-- Expected for sample: 35
print("Result: " .. result)

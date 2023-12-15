input_path = "input"
answer = 0
histories = {}

function all_zeroes(tbl)
  local result = true

  for _, number in ipairs(tbl) do
    if number ~= 0 then
      result = false
      break
    end
  end

  return result
end

function get_next_sequence(sequence)
  local differences = {}
  for i = 2, #sequence do
    table.insert(differences, sequence[i] - sequence[i-1])
  end
  return differences
end

function print_table(tbl)
  str = ""

  for _, record in ipairs(tbl) do
    str = str == "" and tostring(record) or str .. "," .. tostring(record)
  end

  print(str)
end

for line in io.lines(input_path) do
  local numbers = {}
  for number in line:gmatch("(-?%d+)") do
    table.insert(numbers, tonumber(number))
  end
  table.insert(histories, numbers)
end

for _, history in ipairs(histories) do
  local sequences = {history}

  -- generate differences
  while not all_zeroes(sequences[#sequences]) do
    table.insert(sequences, get_next_sequence(sequences[#sequences]))
  end

  -- add missing values
  for i = #sequences, 2, -1 do
    local prev_seq = sequences[i-1]
    local seq = sequences[i]
    table.insert(prev_seq, 1, prev_seq[1] - seq[1])
  end

  answer = answer + sequences[1][1]
end

-- Expected for sample: 114
print("Answer: " .. tostring(answer))

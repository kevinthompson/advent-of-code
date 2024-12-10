require_relative('../../lib/support')

solve example: 2858 do |input|
  blocks = []
  chunks = {
    file: {},
    free: {}
  }

  input.chomp.each_char.with_index do |char, index|
    count = char.to_i

    if count > 0
      type = index.even? ? :file : :free
      str = type == :file ? index / 2 : '.'
      chunks[type][blocks.size] = [count, str]
      blocks += Array.new(count, str)
      p blocks
    end

    return if index > 20
  end

  chunks[:file].to_a.reverse.each do |file_index, (file_size, file_id)|
    free_index, (free_size, _) = chunks[:free].find do |index, (free_size, _)|
      index < file_index && free_size >= file_size
    end

    if free_index
      (free_index...(free_index + file_size)).each do |block_index|
        blocks[block_index] = file_id
      end

      (file_index...(file_index + file_size)).each do |block_index|
        blocks[block_index] = '.'
      end

      remaining = free_size - file_size
      chunks[:free].delete(free_index)
      chunks[:free][free_index + file_size] = [remaining, '.'] if remaining > 0
    end
  end

  blocks.each_with_index.sum do |char, index|
    char.to_i * index
  end
end

# 6432393509374 => too high

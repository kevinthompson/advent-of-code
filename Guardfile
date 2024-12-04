guard :shell do
  watch(%r{\d+/\d+/.*\.rb}) do |match|
    `reset; ruby #{match[0]}`
  end
end

TEMPLATE_DIRECTORY = '.template'.freeze

task :new, [:name] do
  # Determine new directory
  year = Time.new.year
  day = Dir["#{year}/**"].count + 1
  destination = "#{year}/#{day.to_s.rjust(2, '0')}"

  # Duplicate template
  FileUtils.mkdir_p(year.to_s)
  FileUtils.cp_r(TEMPLATE_DIRECTORY, destination)

  # Open part 1 in new directory
  `code -r #{destination}/part_1.rb`

  # Run Guard
  Rake::Task[:watch].invoke
end

task :watch do
  exec 'reset; bundle exec guard'
end

task default: [:watch]

require 'faraday'
require 'rainbow/refinement'
using Rainbow

TEMPLATE_DIRECTORY = '.template'.freeze
COOKIE_PATH = "#{__dir__}/.cookie".freeze

task :new do
  # Fetch next exercise
  Rake::Task[:next].invoke(open_in_browser: true)

  # Run Guard
  Rake::Task[:watch].invoke
end

task :next, [:open_in_browser] do |t, args|
  args.with_defaults(open_in_browser: false)

  # Determine new directory
  year = Time.new.year
  day = Dir["#{year}/**"].count + 1

  # Get input
  if File.exist?(COOKIE_PATH)
    connection = Faraday.new(
      url: 'https://adventofcode.com',
      headers: {
        'Cookie' => File.read(COOKIE_PATH)
      }
    )

    response = connection.get("#{year}/day/#{day}/input")

    if response.success?
      destination = "#{year}/#{day.to_s.rjust(2, '0')}"

      # Duplicate template
      FileUtils.mkdir_p(year.to_s)
      FileUtils.cp_r(TEMPLATE_DIRECTORY, destination)

      # Write input data
      File.open("#{destination}/input.txt", 'wb') { |file| file.write(response.body) }
    else
      puts "Error! The exercise for December #{day}, #{year} is not available.".red
      print response.body
    end
  else
    puts 'Error! Cookie not found.'.red
  end

  # Open browser to exercise
  `open https://adventofcode.com/#{year}/day/#{day}` if args.open_in_browser
end

task :watch do
  exec 'reset; bundle exec guard'
end

task default: [:watch]

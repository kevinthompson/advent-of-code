task :new, [:name] do
  year = Time.new.year
  day = Dir["#{year}/**"].count + 1
  template_dir = '.template'
  destination_dir = "#{year}/#{day.to_s.rjust(2, '0')}"
  FileUtils.mkdir_p(year.to_s)
  FileUtils.cp_r(template_dir, destination_dir)
  Rake::Task[:watch].invoke
end

task :watch do
  `reset; bundle exec guard`
end

task default: [:watch]

require "optparse"
require_relative "../chronal_calibrator"

class ChronalCalibrator
  class Command
    USAGE_INSTRUCTIONS = "Usage: calibrate input_path [options]".freeze

    def initialize(argv)
      @argv = argv
    end

    def execute
      parse_options!

      if input_path
        if input_file_exists?
          print "Calibrating values from #{input_path}...\n"
          print chronal_calibrator.result
        else
          print "Provided input file does not exist."
        end
      else
        print USAGE_INSTRUCTIONS
      end

      print "\n"
    end

    private

    attr_reader :argv, :options

    def input_path
      argv[0]
    end

    def input_file_exists?
      input_path && File.exists?(input_path)
    end

    def chronal_calibrator
      ChronalCalibrator.new(
        strategy: options[:strategy],
        values: values,
      )
    end

    def values
      File.read(input_path).lines.map(&:strip).map(&:to_i)
    end

    def parse_options!
      @options = {}

      OptionParser.new do |opts|
        opts.banner = USAGE_INSTRUCTIONS

        opts.on("-s", "--strategy STRATEGY", "Define strategy") do |strategy|
          @options[:strategy] = strategy
        end

        opts.on("-h", "--help", "Show help text") do
          puts opts
          exit
        end
      end.parse!

      @options
    end
  end
end

# frozen_string_literal: true

require "optparse"
require "English"

module Kozo
  class CLI
    attr_reader :parser, :args, :command_args

    def initialize(args)
      @parser = OptionParser.new("#{File.basename($PROGRAM_NAME)} [global options] command [command options]") do |o|
        o.on("Global options:")
        o.on("-d", "--directory=DIRECTORY", "Set working directory")
        o.on("-v", "--verbose", "Turn on verbose logging")
        o.on("-h", "--help", "Display this message") { usage }
        o.separator("\n")
        o.on("Commands:")
        commands.each { |(name, description)| o.on("    #{name.ljust(33)}#{description}") }
        o.separator("\n")
      end

      @args = args
      @command_args = []

      parse!
    end

    def parse!
      # Parse command line arguments (in order) and extract non-option arguments
      # (unrecognized option values). Raise for invalid option arguments (unrecognized
      # option keys). "--foo FOO --bar BAR" will result in "--foo" and "FOO" being parsed
      # correctly, "--bar" and "BAR" will be extracted.
      parser.order!(args, into: Kozo.options) { |value| command_args << value }
    rescue OptionParser::InvalidOption => e
      @command_args += e.args
      retry
    end

    def start
      command = command_args.shift

      return usage unless command

      klass = "Kozo::Commands::#{command.camelize}".safe_constantize

      return usage(tail: "#{File.basename($PROGRAM_NAME)}: unknown command: #{command}") unless klass

      klass
        .new(command_args)
        .start
    rescue Error => e
      Kozo.logger.fatal e.message
    end

    private

    def usage(code: 1, tail: nil)
      puts parser.to_s
      puts tail if tail

      exit code
    end

    def commands
      Command.descendants.sort_by(&:to_s).map { |k| [k.name.demodulize.underscore, k.description] }
    end
  end
end

# frozen_string_literal: true

require "optparse"
require "English"

module Kozo
  class CLI
    attr_reader :parser, :args, :command_args

    def initialize(args)
      @parser = OptionParser.new("#{File.basename($PROGRAM_NAME)} [global options] command [subcommand] [command options]") do |o|
        o.on("Global options:")
        o.on("-d", "--directory=DIRECTORY", "Set working directory")
        o.on("-v", "--verbose", "Turn on verbose logging")
        o.on("-D", "--debug", "Turn on debug logging")
        o.on("-h", "--help", "Display this message") { usage }
        o.separator("\n")
        o.on("Commands:")
        commands.each do |(name, description, subcommands)|
          o.on("    #{name.ljust(33)}#{description}")

          subcommands.each do |(sb_name, sb_description)|
            o.on("      #{sb_name.ljust(31)}#{sb_description}")
          end
        end
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

      raise UsageError, "no command specified" unless command

      klass = "Kozo::Commands::#{command.camelize}".safe_constantize

      raise UsageError, "unknown command: #{command}" unless klass

      klass
        .new(*command_args)
        .start
    rescue UsageError => e
      # Don't print tail if no message was passed
      return usage if e.message == e.class.name

      usage(tail: "#{File.basename($PROGRAM_NAME)}: #{e.message}")
    rescue Error => e
      Kozo.logger.fatal e.message
    end

    private

    def usage(code: 1, tail: nil)
      Kozo.logger.info parser.to_s
      Kozo.logger.info tail if tail

      raise ExitError, code
    end

    def commands
      Command.subclasses.sort_by(&:name).map do |k|
        [
          k.name.demodulize.underscore,
          k.description,
          k.descendants.sort_by(&:name).map { |s| [s.name.demodulize.underscore, s.description] },
        ]
      end
    end
  end
end

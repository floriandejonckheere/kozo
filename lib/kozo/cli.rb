# frozen_string_literal: true

require "optparse"

module Kozo
  class CLI
    attr_reader :options, :command_args

    def initialize(args)
      @options = {
        verbose: false,
      }

      parser = OptionParser.new("#{$PROGRAM_NAME} [OPTIONS] COMMAND") do |o|
        o.on("-v", "--verbose", "Turn on verbose logging")
        o.on_tail("-h", "--help", "Display this message") { abort(o.to_s) }
      end

      @command_args = []

      # Parse command line arguments (in order) and extract non-option arguments
      # (unrecognized option values). Raise for invalid option arguments (unrecognized
      # option keys). "--foo FOO --bar BAR" will result in "--foo" and "FOO" being parsed
      # correctly, "--bar" and "BAR" will be extracted.
      begin
        parser.order!(args, into: options) { |value| command_args << value }
      rescue OptionParser::InvalidOption => e
        @command_args += e.args
        retry
      end
    end

    def start
      command = command_args.shift

      Command
        .const_get(command.camelize)
        .new(command_args, options)
        .start
    end
  end
end

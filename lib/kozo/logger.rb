# frozen_string_literal: true

require "delegate"
require "logger"

module Kozo
  class Logger < SimpleDelegator
    def initialize
      super(::Logger.new($stdout, level: level, formatter: formatter))
    end

    private

    def level
      Kozo.options.verbose? ? "debug" : ENV.fetch("LOG_LEVEL", "info")
    end

    def formatter
      Formatter.new
    end

    class Formatter < ::Logger::Formatter
      def call(severity, _time, _progname, msg)
        abort("#{File.basename($PROGRAM_NAME)}: #{msg[0].downcase}#{msg[1..]}") if severity == "FATAL"

        "#{msg}\n"
      end
    end
  end
end

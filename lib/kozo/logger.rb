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
      Kozo.options.verbose? ? "debug" : "info"
    end

    def formatter
      proc do |severity, _time, _progname, msg|
        abort("#{File.basename($PROGRAM_NAME)}: #{msg}".white.on_red) if severity == "FATAL"

        msg = "#{msg}\n"
        msg = msg.yellow if severity == "DEBUG"
        msg = msg.red if severity == "ERROR"

        msg
      end
    end

    class Debug < Logger
      def level
        Kozo.options.debug? ? "debug" : "fatal"
      end

      def formatter
        ->(_severity, _time, _progname, msg) { msg.magenta }
      end
    end
  end
end

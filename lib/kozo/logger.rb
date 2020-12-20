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
      ENV.fetch("LOG_LEVEL", "info")
    end

    def formatter
      level == "debug" ? ::Logger::Formatter.new : Formatter.new
    end

    class Formatter < ::Logger::Formatter
      def call(_severity, _time, _progname, msg)
        "#{msg}\n"
      end
    end
  end
end

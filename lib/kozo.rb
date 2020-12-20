# frozen_string_literal: true

require "logger"

require "zeitwerk"
require "active_support/all"

module Kozo
  class << self
    attr_reader :loader

    def root
      @root ||= Pathname.new(File.expand_path(File.join("..", ".."), __FILE__))
    end

    def env
      @env ||= Environment.new
    end

    def logger
      @logger ||= Logger.new(level: ENV.fetch("LOG_LEVEL", "info"))
    end

    def setup
      @loader = Zeitwerk::Loader.for_gem

      loader.inflector.inflect(
        "cli" => "CLI",
      )
      loader.setup
      loader.eager_load
    end
  end
end

def reload!
  Kozo.loader.reload
end

Kozo.setup

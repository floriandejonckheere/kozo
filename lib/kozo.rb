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

    def config
      @config ||= Configuration.new
    end

    def env
      @env ||= Environment.new
    end

    def logger
      @logger ||= Logger.new(level: Kozo.config.log_level)
    end

    def setup
      @loader = Zeitwerk::Loader.for_gem

      loader.setup
      loader.eager_load
    end
  end
end

def reload!
  Kozo.loader.reload
end

Kozo.setup

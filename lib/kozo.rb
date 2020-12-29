# frozen_string_literal: true

require "zeitwerk"
require "active_support/all"

module Kozo
  class << self
    attr_reader :loader

    def root
      @root ||= Pathname.new(File.expand_path(File.join("..", ".."), __FILE__))
    end

    def options
      @options ||= Options.new
    end

    def container
      @container ||= Container.new
    end

    def logger
      @logger ||= Logger.new
    end

    def setup
      @loader = Zeitwerk::Loader.for_gem

      instance_eval(File.read(root.join("config/inflections.rb")))

      loader.enable_reloading
      loader.setup
      loader.eager_load

      container.instance_eval(File.read(root.join("config/dependencies.rb")))
    end
  end
end

def reload!
  Kozo.loader.reload
end

Kozo.setup

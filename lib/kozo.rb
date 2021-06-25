# frozen_string_literal: true

require "active_support/all"
require "active_model"
require "dinja"
require "zeitwerk"

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
      @container ||= Dinja::Container.new
    end

    def logger
      @logger ||= Logger.new
    end

    def setup
      @loader = Zeitwerk::Loader.for_gem

      # Register inflections
      instance_eval(File.read(root.join("config/inflections.rb")))

      # Set up code loader
      loader.enable_reloading
      loader.ignore(root.join("lib/**/*/dependencies.rb"))
      loader.setup
      loader.eager_load

      # Register dependencies
      Dir["lib/**/*/dependencies.rb", "config/dependencies.rb"].each { |d| container.instance_eval(File.read(d)) }
    end
  end
end

def reload!
  Kozo.loader.reload
end

Kozo.setup

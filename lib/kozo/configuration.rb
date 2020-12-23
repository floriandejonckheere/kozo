# frozen_string_literal: true

module Kozo
  class Configuration
    attr_writer :backend
    attr_accessor :directory, :providers, :resources

    def initialize(directory)
      @directory = directory
      @providers = {}
      @resources = {}
    end

    def backend
      @backend ||= Backends::Local.new(directory)
    end

    def parse!
      dsl = DSL.new(self)
      Dir[File.join(directory, "*.kz")]
        .sort
        .each { |file| dsl.instance_eval(File.read(file)) }
    end
  end
end

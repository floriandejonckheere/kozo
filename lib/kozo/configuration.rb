# frozen_string_literal: true

module Kozo
  class Configuration
    attr_writer :backend
    attr_accessor :directory, :providers, :resources

    def initialize(directory)
      @directory = directory
      @providers = {}
      @resources = Set.new
    end

    def backend
      @backend ||= Kozo
        .container
        .resolve("backend.local", self, directory)
    end

    def parse!
      dsl = DSL.new(self)

      Dir[File.join(directory, "*.kz")]
        .each { |file| dsl.instance_eval(File.read(file)) }
    end

    def to_s
      "directory: #{directory}"
    end
  end
end

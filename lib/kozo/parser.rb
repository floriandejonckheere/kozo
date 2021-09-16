# frozen_string_literal: true

module Kozo
  class Parser
    attr_reader :directory

    def initialize(directory)
      @directory = directory
    end

    def call
      configuration = Configuration.new(directory)
      dsl = DSL.new(configuration)

      Dir[File.join(directory, "main.kz"), File.join(directory, "*.kz")]
        .uniq
        .each { |file| dsl.instance_eval(File.read(file)) }

      configuration
    end
  end
end

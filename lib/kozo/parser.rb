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

      Dir[File.join(directory, "main.kz"), File.join(directory, "**", "*.kz")]
        .uniq
        .reject { |file| ignores.any? { |ignore| file.include?(ignore) } }
        .each { |file| dsl.instance_eval(File.read(file)) }

      configuration
    end

    private

    def ignores
      @ignores ||= begin
        File
          .readlines(File.join(directory, ".kzignore"))
          .map(&:chomp)
      rescue Errno::ENOENT
        []
      end
    end
  end
end

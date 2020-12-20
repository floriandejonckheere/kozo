# frozen_string_literal: true

module Kozo
  class Workspace
    attr_reader :directory, :dsl

    def initialize(directory)
      @directory = directory
      @dsl = DSL.new

      configurations.each { |configuration| dsl.instance_eval(File.read(configuration)) }
    end

    def configurations
      @configurations ||= Dir[File.join(directory, "*.kz")].sort
    end
  end
end

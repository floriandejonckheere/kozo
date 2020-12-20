# frozen_string_literal: true

module Kozo
  class Workspace
    attr_reader :directory
    attr_writer :backend

    def initialize(directory)
      @directory = directory

      dsl = DSL.new(self)
      Dir[File.join(directory, "*.kz")]
        .sort
        .each { |configuration| dsl.instance_eval(File.read(configuration)) }
    end

    def backend
      @backend ||= Backends::Local.new(directory)
    end
  end
end

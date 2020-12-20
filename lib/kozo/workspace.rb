# frozen_string_literal: true

module Kozo
  class Workspace
    attr_reader :directory, :backend

    def initialize(directory)
      @directory = directory

      dsl = DSL.new(self)
      Dir[File.join(directory, "*.kz")]
        .sort
        .each { |configuration| dsl.instance_eval(File.read(configuration)) }
    end
  end
end

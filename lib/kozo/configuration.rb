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

    delegate :state, to: :backend

    def to_s
      "directory: #{directory}"
    end
  end
end

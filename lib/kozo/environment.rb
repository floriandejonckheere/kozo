# frozen_string_literal: true

module Kozo
  class Environment
    attr_accessor :directory

    def initialize(directory)
      @directory = directory
    end

    def configuration
      @configuration ||= Configuration
        .new(Kozo.options.directory)
        .tap(&:parse!)
    end

    def state
      @state ||= configuration.backend.state
    end
  end
end

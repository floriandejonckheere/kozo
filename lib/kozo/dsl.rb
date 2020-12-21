# frozen_string_literal: true

module Kozo
  class DSL
    attr_reader :workspace

    def initialize(workspace)
      @workspace = workspace
    end

    def kozo(&_block)
      yield
    end

    def backend(type)
      Kozo.logger.debug "Initializing backend #{type}"

      workspace.backend = Kozo.container.resolve("backend.#{type}", workspace.directory, quiet: true)

      Kozo.logger.fatal "Unknown backend: #{type}" unless workspace.backend

      yield workspace.backend if block_given?
    end

    def provider(type, &_block)
      Kozo.logger.debug "Initializing provider #{type}"
    end

    def resource(type, name, &_block)
      Kozo.logger.debug "Initializing resource #{type} #{name}"
    end
  end
end

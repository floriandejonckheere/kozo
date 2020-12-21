# frozen_string_literal: true

module Kozo
  class DSL
    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def kozo(&_block)
      yield
    end

    def backend(type)
      Kozo.logger.debug "Initializing backend #{type}"

      backend = Kozo.container.resolve("backend.#{type}", configuration.directory, quiet: true)

      Kozo.logger.fatal "Unknown backend: #{type}" unless backend

      yield backend if block_given?

      configuration.backend = backend
    end

    def provider(type, &_block)
      Kozo.logger.debug "Initializing provider #{type}"
    end

    def resource(type, name, &_block)
      Kozo.logger.debug "Initializing resource #{type} #{name}"
    end
  end
end

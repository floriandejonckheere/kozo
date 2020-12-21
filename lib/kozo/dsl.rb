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

      Kozo.logger.fatal "unknown backend type: #{type}" unless backend

      yield backend if block_given?

      configuration.backend = backend
    end

    def provider(type)
      Kozo.logger.debug "Initializing provider #{type}"

      provider = Kozo.container.resolve("provider.#{type}", quiet: true)

      Kozo.logger.fatal "unknown provider type: #{type}" unless provider

      yield provider if block_given?

      configuration.providers << provider
    end

    def resource(type, name)
      Kozo.logger.debug "Initializing resource #{type} #{name}"

      resource = Kozo.container.resolve("resource.#{type}", quiet: true)

      Kozo.logger.fatal "unknown resource type: #{type}" unless resource

      yield resource if block_given?

      configuration.resources << resource
    end
  end
end

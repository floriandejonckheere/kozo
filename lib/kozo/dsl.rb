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
      backend = resolve(:backend, type)

      yield backend if block_given?

      configuration.backend = backend
    end

    def provider(type)
      provider = resolve(:provider, type)

      yield provider if block_given?

      configuration.providers[provider.class.name] = provider
    end

    def resource(type, name)
      resource = resolve(:resource, type, name)
      resource.provider = configuration.providers[resource.class.provider]

      Kozo.logger.fatal "provider #{resource.class.provider}" unless resource.provider

      yield resource if block_given?

      configuration.resources[resource.class.name] = resource
    end

    private

    def resolve(resource, type, name = nil)
      Kozo.logger.debug "initializing #{resource} #{type} #{name}"

      Kozo.container.resolve("#{resource}.#{type}")
    rescue Container::DependencyNotRegistered
      Kozo.logger.fatal "unknown #{resource} type: #{type}"
    end
  end
end

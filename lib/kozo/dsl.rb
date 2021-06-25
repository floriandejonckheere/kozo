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
      backend = resolve(:backend, type, configuration)

      yield backend if block_given?

      configuration.backend = backend
    end

    def provider(type)
      provider = resolve(:provider, type)

      yield provider if block_given?

      configuration.providers[provider.class.provider_name] = provider
    end

    def resource(type, name)
      resource = resolve(:resource, type, name)
      resource.provider = configuration.providers[resource.class.provider_name]

      raise InvalidResource, "Provider #{resource.class.provider_name} not configured" unless resource.provider

      yield resource if block_given?

      configuration.resources << resource
    end

    private

    def resolve(resource, type, *args)
      Kozo.logger.debug "Initializing #{resource} #{type} #{args.join(' ')}"

      Kozo.container.resolve("#{resource}.#{type}", *args)
    rescue Dinja::Container::DependencyNotRegistered
      raise InvalidResource, "Unknown #{resource} type: #{type}"
    end

    class InvalidResource < Error; end
  end
end

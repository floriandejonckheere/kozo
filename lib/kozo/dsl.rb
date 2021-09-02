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

      provider.setup

      configuration.providers[provider.provider_name] = provider
    end

    def resource(type, state_name)
      resource = resolve(:resource, type)
      resource.state_name = state_name

      raise InvalidResource, "resource #{resource.address} already defined" if configuration.resources.include?(resource)

      resource.provider = configuration.providers[resource.class.provider_name]

      raise InvalidResource, "provider #{resource.class.provider_name} not configured" unless resource.provider

      yield resource if block_given?

      configuration.resources << resource
    end

    private

    def resolve(resource, type, *args)
      Kozo.logger.debug "Initializing #{resource} #{type}#{" with options #{args.join(' ')}" if args.any?}"

      Kozo.container.resolve("#{resource}.#{type}", *args)
    rescue Dinja::Container::DependencyNotRegistered
      raise InvalidResource, "unknown #{resource} type: #{type}"
    end
  end
end

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

      resource.provider = configuration.providers[resource.provider_name]

      raise InvalidResource, "provider #{resource.provider_name} not configured" unless resource.provider

      yield resource if block_given?

      configuration.resources << resource
    end

    def method_missing(method_name, *arguments, &block)
      resource_class = Kozo
        .container
        .resolve("resource.#{method_name}")
        .class

      Reference.new(resource_class, configuration)
    rescue Dinja::Container::DependencyNotRegistered
      super
    end

    def respond_to_missing?(method_name, include_private = false)
      Kozo.container.resolve!("resource.#{method_name}").present? || super
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

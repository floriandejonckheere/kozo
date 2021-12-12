# frozen_string_literal: true

module Kozo
  class Reference
    attr_reader :resource_class, :state_name, :configuration

    def initialize(resource_class, configuration)
      @resource_class = resource_class
      @configuration = configuration
    end

    def method_missing(method_name, *_arguments)
      @state_name = method_name.to_s

      self
    end

    def respond_to_missing?(_method_name, _include_private = false)
      true
    end

    def as_s
      raise StateError, "invalid resource address: #{address}" unless state_name

      resource = configuration
        .resources
        .find { |r| r.address == address }

      raise StateError, "no such resource address: #{address}" unless resource

      # FIXME: will always be nil for existing resources, since the configuration does not contain this information
      # FIXME: will be solved once a unified state is introduced
      resource.id? ? resource.id.as_s : "(known after apply)"
    end

    private

    def address
      "#{resource_class.resource_name}.#{state_name}"
    end
  end
end

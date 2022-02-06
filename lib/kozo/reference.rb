# frozen_string_literal: true

module Kozo
  class Reference
    attr_reader :resource_class, :state_name, :configuration

    def initialize(resource_class, configuration)
      @resource_class = resource_class
      @configuration = configuration
    end

    def method_missing(method_name, *_arguments)
      # Raise NoMethodError when `state_name` was already set (usually because of a programming error)
      return super if @state_name

      @state_name = method_name.to_s

      self
    end

    def respond_to_missing?(_method_name, _include_private = false)
      true
    end

    def as_s
      resource.id? ? resource.id.as_s : "(known after apply)"
    end

    def resource
      @resource ||= begin
        raise StateError, "invalid resource address: #{address}" unless state_name

        resource = configuration
          .changes
          .find { |r| r.address == address }

        raise StateError, "no such resource address: #{address}" unless resource

        resource
      end
    end

    delegate :id, to: :resource

    private

    def address
      "#{resource_class.resource_name}.#{state_name}"
    end
  end
end

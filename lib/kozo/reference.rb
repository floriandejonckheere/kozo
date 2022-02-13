# frozen_string_literal: true

module Kozo
  class Reference
    attr_reader :resource_class, :state_name, :id

    def initialize(resource_class: nil, id: nil)
      @resource_class = resource_class
      @id = id
    end

    def method_missing(method_name, *_arguments)
      # Raise NoMethodError when `state_name` was already set (usually because of a programming error)
      return super if @state_name

      @state_name = method_name.to_s

      self
    end

    def resolve(configuration)
      raise StateError, "no state name specified" unless state_name

      resource = configuration
        .state
        .resources
        .find { |r| r.address == address }

      raise StateError, "no such resource address: #{address}" unless resource

      @id = resource.id
    end

    def respond_to_missing?(_method_name, _include_private = false)
      true
    end

    def to_h
      {
        id: id,
      }
    end

    def as_h
      id
    end

    def as_s
      id&.as_s || "(known after apply)"
    end

    private

    def address
      "#{resource_class.resource_name}.#{state_name}"
    end
  end
end

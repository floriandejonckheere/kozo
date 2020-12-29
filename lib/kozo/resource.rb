# frozen_string_literal: true

module Kozo
  class Resource
    attr_accessor :id, :provider

    class_attribute :resource_name, :provider_name

    def ==(other)
      id == other.id
    end

    def to_h
      {
        provider: provider_name,
        resource: resource_name,
      }
    end
  end
end

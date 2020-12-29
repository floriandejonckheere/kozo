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
        meta: meta,
        data: data,
      }
    end

    def self.from_h(hash)
      Kozo
        .container
        .resolve("resource.#{hash.dig(:meta, :resource)}")
        .tap { |r| hash[:data].each { |k, v| r.send(:"#{k}=", v) } }
    end

    protected

    def data
      raise NotImplementedError
    end

    private

    def meta
      {
        provider: provider_name,
        resource: resource_name,
      }
    end
  end
end

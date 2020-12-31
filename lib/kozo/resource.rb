# frozen_string_literal: true

module Kozo
  class Resource
    include Attribute

    attr_accessor :id, :provider, :state_name

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
        .tap { |r| r.state_name = hash.dig(:meta, :name) }
    end

    protected

    ##
    # Collect resource data
    #
    # @return Hash
    #
    def data
      raise NotImplementedError
    end

    ##
    # Refetch resource from remote infrastructure
    #
    def refresh!
      raise NotImplementedError
    end

    private

    def meta
      {
        name: state_name,
        provider: provider_name,
        resource: resource_name,
      }
    end
  end
end

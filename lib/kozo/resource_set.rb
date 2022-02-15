# frozen_string_literal: true

module Kozo
  class ResourceSet
    include Enumerable

    attr_reader :resources

    def initialize(resources = [])
      @resources = resources.to_h { |r| [r.address, r] }
    end

    def each
      resources.values.each
    end

    def [](resource)
      resources[resource.address]
    end

    def include?(resource)
      resources.key?(resource.address)
    end

    def <<(resource)
      resources[resource.address] = resource
    end

    def delete(resource)
      resources.delete(resource.address)
    end
  end
end

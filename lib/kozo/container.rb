# frozen_string_literal: true

module Kozo
  class Container
    attr_reader :dependencies

    def initialize
      @dependencies = {}
    end

    def register(key, force: false, &block)
      raise DependencyAlreadyRegistered, "Dependency alreadyd registered: #{key}" unless force || !dependencies[key]

      dependencies[key] = block
    end

    def resolve(key, *args, quiet: false, &block)
      return dependencies[key].call(*args, &block) if dependencies[key]

      raise DependencyNotRegistered, "Dependency not registered: #{key}" unless quiet
    end

    class DependencyAlreadyRegistered < Error; end

    class DependencyNotRegistered < Error; end
  end
end

# frozen_string_literal: true

module Kozo
  class Container
    attr_reader :dependencies

    def initialize
      @dependencies = {}
    end

    def register(key, force: false, &block)
      raise DependencyAlreadyRegistered, key unless force || !dependencies[key]

      dependencies[key] = block
    end

    def resolve(key, *args, quiet: false, &block)
      return dependencies[key].call(*args, &block) if dependencies[key]

      raise DependencyNotRegistered, key unless quiet
    end

    class DependencyAlreadyRegistered < StandardError
      def initialize(message)
        super("Dependency already registered: #{message}")
      end
    end

    class DependencyNotRegistered < StandardError
      def initialize(message)
        super("Dependency not registered: #{message}")
      end
    end
  end
end

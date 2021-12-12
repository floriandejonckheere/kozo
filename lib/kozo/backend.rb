# frozen_string_literal: true

module Kozo
  class Backend
    attr_accessor :configuration, :directory

    def initialize(configuration, directory)
      @configuration = configuration
      @directory = directory
    end

    def state
      @state ||= State
        .new(resources, data[:version], data[:kozo_version])
    end

    def state=(value)
      @state = value

      self.data = value.to_h
    end

    ##
    # Create necessary backend files/structures if they do not exist
    #
    def initialize!
      raise NotImplementedError
    end

    def ==(other)
      directory == other.directory
    end

    protected

    ##
    # Read state from backend
    #
    # @return Hash
    #
    def data
      raise NotImplementedError
    end

    ##
    # Write state to backend
    #
    # @param value Hash
    #
    def data=(value)
      raise NotImplementedError
    end

    private

    def resources
      data
        .fetch(:resources, [])
        .map do |hash|
        provider = configuration.providers[hash.dig(:meta, :provider)]

        raise StateError, "provider #{hash.dig(:meta, :provider)} not configured" unless provider

        Resource
          .from_h(hash)
          .tap { |r| r.provider = provider }
      end
    end
  end
end

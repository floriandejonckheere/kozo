# frozen_string_literal: true

module Kozo
  class Backend
    attr_accessor :configuration, :directory

    def initialize(configuration, directory)
      @configuration = configuration
      @directory = directory
    end

    def state
      @state ||= State.new(resources)
    end

    def state=(value)
      @state = value

      self.data = value.to_h
    end

    def validate!
      state_version = data.fetch(:version)
      kozo_version = data.fetch(:kozo_version)

      raise InvalidState, "Invalid version in state: got #{state_version}, expected #{State::VERSION}" unless state_version == State::VERSION

      return if kozo_version == Kozo::VERSION

      raise InvalidState, "Invalid kozo version in state: got #{kozo_version}, expected #{Kozo::VERSION}"
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

        raise InvalidState, "Provider #{hash.dig(:meta, :provider)} not configured" unless provider

        Resource
          .from_h(hash)
          .tap { |r| r.provider = provider }
      end
    end

    class InvalidState < Error; end
  end
end

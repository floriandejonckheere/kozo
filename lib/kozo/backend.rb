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

      unless state_version == State::VERSION
        Kozo.logger.fatal "Invalid version in state: got #{state_version}, expected #{State::VERSION}"
      end

      return if kozo_version == Kozo::VERSION

      Kozo.logger.fatal "Invalid kozo version in state: got #{kozo_version}, expected #{Kozo::VERSION}"
    end

    ##
    # Create necessary backend files/structures if they do not exist
    #
    def initialize!
      raise NotImplementedError
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
        .map { |h| Resource.from_h(h) }
    end
  end
end

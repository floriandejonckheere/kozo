# frozen_string_literal: true

module Kozo
  class Backend
    attr_accessor :directory

    VERSION = 1

    def initialize(directory)
      @directory = directory
    end

    protected

    ##
    # Create necessary backend files/structures if they do not exist
    #
    def initialize!
      raise NotImplementedError
    end

    ##
    # Read state from backend
    #
    def state
      raise NotImplementedError
    end

    ##
    # Write state to backend
    #
    def state=(_value)
      raise NotImplementedError
    end

    def meta
      {
        version: VERSION,
        kozo_version: Kozo::VERSION,
      }
    end
  end
end

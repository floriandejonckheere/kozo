# frozen_string_literal: true

module Kozo
  class State
    VERSION = 1

    attr_accessor :resources

    def initialize(resources = [], version = VERSION, kozo_version = Kozo::VERSION)
      @resources = Array(resources)

      raise StateError, "invalid version in state: got #{version}, expected #{State::VERSION}" unless version == State::VERSION
      raise StateError, "invalid kozo version in state: got #{kozo_version}, expected #{Kozo::VERSION}" unless kozo_version == Kozo::VERSION
    end

    def ==(other)
      resources == other.resources
    end

    def to_h
      {
        version: VERSION,
        kozo_version: Kozo::VERSION,
        resources: resources.map(&:to_h),
      }
    end
  end
end

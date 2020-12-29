# frozen_string_literal: true

module Kozo
  class State
    VERSION = 1

    attr_accessor :resources

    def initialize(resources = [])
      @resources = resources
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

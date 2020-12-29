# frozen_string_literal: true

module Kozo
  class State
    attr_accessor :resources

    def initialize(resources = [])
      @resources = resources
    end

    def ==(other)
      resources == other.resources
    end

    def to_h
      {
        resources: resources.map(&:to_h),
      }
    end
  end
end

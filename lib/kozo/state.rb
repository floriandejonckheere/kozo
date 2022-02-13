# frozen_string_literal: true

module Kozo
  class State
    VERSION = 2

    attr_accessor :resources, :version

    def initialize(resources = [], version = VERSION, verify: true)
      @resources = Array(resources)
      @version = version

      raise StateError, "unexpected version in state: got #{version}, expected #{State::VERSION}\nRun `#{File.basename($PROGRAM_NAME)} state upgrade` to upgrade your state file" unless compatible? || !verify
    end

    def compatible?
      version == State::VERSION
    end

    def ==(other)
      resources == other.resources
    end

    def to_h
      {
        version: VERSION,
        resources: resources.map(&:to_h),
      }
    end
  end
end

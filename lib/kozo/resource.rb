# frozen_string_literal: true

module Kozo
  class Resource
    attr_accessor :id

    def ==(other)
      id == other.id
    end

    def self.provider
      raise NotImplementedError
    end
  end
end

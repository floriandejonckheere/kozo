# frozen_string_literal: true

module Kozo
  class Resource
    attr_accessor :id

    def ==(other)
      id == other.id
    end
  end
end

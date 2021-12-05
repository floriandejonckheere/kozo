# frozen_string_literal: true

module Kozo
  class Type
    def self.lookup(type)
      "Kozo::Types::#{type.to_s.camelize}".constantize
    rescue NameError
      raise ArgumentError, "No such type: #{type}"
    end

    def self.cast(value); end

    def self.as_json(value); end
  end
end

# frozen_string_literal: true

module Kozo
  module Types
    class Hash < Type
      def self.cast(value)
        return unless value

        value.to_h
      rescue TypeError, NoMethodError => e
        raise ArgumentError, e
      end

      def self.serialize(value)
        value
      end
    end
  end
end

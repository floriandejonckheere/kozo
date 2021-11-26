# frozen_string_literal: true

module Kozo
  module Types
    class Date < Type
      def self.cast(value)
        return unless value

        ::Date.parse(value)
      rescue ::Date::Error => e
        raise ArgumentError, e
      end

      def self.serialize(value)
        value&.iso8601
      end
    end
  end
end

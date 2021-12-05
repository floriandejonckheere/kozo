# frozen_string_literal: true

module Kozo
  module Types
    class Date < Type
      def self.cast(value)
        return unless value
        return value if value.is_a?(::Date)

        ::Date.parse(value)
      rescue ::Date::Error => e
        raise ArgumentError, e
      end

      def self.as_json(value)
        value&.iso8601
      end

      def self.as_s(value)
        value.nil? ? "nil" : value.iso8601
      end
    end
  end
end

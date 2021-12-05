# frozen_string_literal: true

module Kozo
  module Types
    class Time < Type
      def self.cast(value)
        return unless value
        return value if value.is_a?(::Time)

        ::Time.parse(value)
      end

      def self.as_json(value)
        value&.iso8601
      end
    end
  end
end

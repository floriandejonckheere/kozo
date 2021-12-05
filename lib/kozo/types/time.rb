# frozen_string_literal: true

module Kozo
  module Types
    class Time < Type
      def self.cast(value)
        return unless value
        return value if value.is_a?(::Time)

        ::Time.parse(value)
      end
    end
  end
end

# frozen_string_literal: true

module Kozo
  module Types
    class Boolean < Type
      # rubocop:disable Lint/BooleanSymbol
      FALSE_VALUES = [
        false, 0,
        "0", :"0",
        "f", :f,
        "F", :F,
        "false", :false,
        "FALSE", :FALSE,
        "off", :off,
        "OFF", :OFF,
      ].freeze
      # rubocop:enable Lint/BooleanSymbol

      def self.cast(value)
        return if value.nil?

        !FALSE_VALUES.include?(value)
      end
    end
  end
end

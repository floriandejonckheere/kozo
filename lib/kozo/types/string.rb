# frozen_string_literal: true

module Kozo
  module Types
    class String < Type
      def self.cast(value)
        return unless value

        send :String, value
      end

      def self.as_json(value)
        value
      end

      def self.as_s(value)
        value.nil? ? "nil" : "\"#{value}\""
      end
    end
  end
end

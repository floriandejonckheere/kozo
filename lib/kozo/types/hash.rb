# frozen_string_literal: true

module Kozo
  module Types
    class Hash < Type
      def self.cast(value)
        return unless value
        return value if value.is_a?(::Hash)

        value.to_h
      rescue TypeError, NoMethodError => e
        raise ArgumentError, e
      end

      def self.as_json(value)
        value
      end

      def self.as_s(value)
        return "nil" if value.nil?
        return "{}" if value.empty?

        value
          .map { |k, v| "  #{k} = #{v}" }
          .intersperse(",")
          .prepend("{")
          .append("}")
          .join("\n")
      end
    end
  end
end

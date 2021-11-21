# frozen_string_literal: true

module Kozo
  module Types
    class String < Type
      def self.cast(value)
        value.to_s
      end

      def self.serialize(value)
        value
      end
    end
  end
end

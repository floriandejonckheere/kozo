# frozen_string_literal: true

module Kozo
  module Types
    class Float < Type
      def self.cast(value)
        return unless value

        send :Float, value
      end

      def self.serialize(value)
        value
      end
    end
  end
end

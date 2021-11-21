# frozen_string_literal: true

module Kozo
  module Types
    class Date < Type
      def self.cast(value)
        ::Date.parse(value)
      end

      def self.serialize(value)
        value.iso8601
      end
    end
  end
end

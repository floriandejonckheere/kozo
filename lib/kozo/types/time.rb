# frozen_string_literal: true

module Kozo
  module Types
    class Time < Type
      def self.cast(value)
        ::Time.parse(value)
      end

      def self.serialize(value)
        value.iso8601
      end
    end
  end
end

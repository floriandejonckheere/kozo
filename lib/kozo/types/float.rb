# frozen_string_literal: true

module Kozo
  module Types
    class Float < Type
      def self.cast(value)
        return unless value

        send :Float, value
      end
    end
  end
end

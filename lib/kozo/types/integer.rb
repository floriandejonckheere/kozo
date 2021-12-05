# frozen_string_literal: true

module Kozo
  module Types
    class Integer < Type
      def self.cast(value)
        return unless value

        send :Integer, value
      end
    end
  end
end

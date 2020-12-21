# frozen_string_literal: true

module Kozo
  module Providers
    class HCloud < Base
      attr_accessor :key

      def ==(other)
        key == other.key
      end
    end
  end
end

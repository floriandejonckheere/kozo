# frozen_string_literal: true

module Kozo
  module Operations
    class Update < Operation
      self.symbol = :~

      def apply
        resource.update!
      end
    end
  end
end

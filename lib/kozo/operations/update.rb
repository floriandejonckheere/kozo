# frozen_string_literal: true

module Kozo
  module Operations
    class Update < Operation
      self.symbol = :~

      def apply(state)
        # Update resource in remote infrastructure
        resource.update!

        # Update resource in-memory state
        state << resource
      end
    end
  end
end

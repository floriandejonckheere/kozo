# frozen_string_literal: true

module Kozo
  module Operations
    class Remove < Operation
      self.symbol = :-

      def apply(state)
        # Destroy resource in remote infrastructure
        resource.destroy!

        # Delete resource in-memory state
        state.resources.delete(resource)
      end
    end
  end
end

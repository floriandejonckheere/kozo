# frozen_string_literal: true

module Kozo
  module Operations
    class Update < Operation
      self.symbol = :~
      self.display_symbol = "~".yellow

      def apply(state)
        # Update resource in remote infrastructure
        resource.update!

        # Update resource in local state
        state.resources.delete(resource)
        state.resources << resource
      end
    end
  end
end

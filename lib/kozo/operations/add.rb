# frozen_string_literal: true

module Kozo
  module Operations
    class Add < Operation
      self.symbol = :+

      def apply(state)
        # Create resource in remote infrastructure
        resource.create!

        # Add resource to in-memory state
        state.resources << resource
      end
    end
  end
end

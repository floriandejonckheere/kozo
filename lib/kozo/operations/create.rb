# frozen_string_literal: true

module Kozo
  module Operations
    class Create < Operation
      self.symbol = :+
      self.display_symbol = "+".green

      def apply(state)
        # Create resource in remote infrastructure
        resource.create!

        # Add resource to in-memory state
        state.resources << resource
      end
    end
  end
end

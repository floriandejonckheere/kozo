# frozen_string_literal: true

module Kozo
  module Operations
    class Destroy < Operation
      self.symbol = :-
      self.display_symbol = "-".red

      def apply(state)
        # Destroy resource in remote infrastructure
        resource.destroy!

        # Delete resource from local state
        state.resources.delete(resource)
      end
    end
  end
end

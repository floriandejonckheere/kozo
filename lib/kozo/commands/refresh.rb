# frozen_string_literal: true

module Kozo
  module Commands
    class Refresh < Kozo::Command
      self.description = "Update the state to match remote infrastructure"

      def start
        # Refresh resources in-memory
        state
          .resources
          .each(&:refresh!)

        # Write state
        configuration
          .backend
          .state = state
      end
    end
  end
end

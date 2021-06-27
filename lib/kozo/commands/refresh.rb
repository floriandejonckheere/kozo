# frozen_string_literal: true

module Kozo
  module Commands
    class Refresh < Kozo::Command
      self.description = "Update the state to match remote infrastructure"

      def start
        Kozo.logger.info "Refreshing #{state.resources.count} resources"
        state
          .resources
          .each(&:refresh!)

        configuration
          .backend
          .state = state
      end
    end
  end
end

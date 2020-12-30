# frozen_string_literal: true

module Kozo
  module Commands
    class Refresh < Kozo::Command
      self.description = "Update the state to match remote infrastructure"

      def start
        environment
          .state
          .resources
          .each(&:refresh!)

        configuration
          .backend
          .state = environment.state
      end
    end
  end
end

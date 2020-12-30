# frozen_string_literal: true

module Kozo
  module Commands
    class Refresh < Kozo::Command
      self.description = "Update the state to match remote infrastructure"

      def start
        environment
          .configuration
          .backend
          .state
          .resources
          .tap { |r| r.each(&:refresh!) }

        configuration.backend.state = state
      end
    end
  end
end

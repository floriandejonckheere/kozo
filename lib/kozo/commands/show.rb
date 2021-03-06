# frozen_string_literal: true

module Kozo
  module Commands
    class Show < Kozo::Command
      self.description = "Show all resources in the state"

      def start
        state
          .resources
          .each { |r| Kozo.logger.info r.to_dsl }
      end
    end
  end
end

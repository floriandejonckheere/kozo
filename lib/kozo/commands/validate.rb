# frozen_string_literal: true

module Kozo
  module Commands
    class Validate < Kozo::Command
      self.description = "Check whether configuration is valid"

      def start
        configuration.parse!

        Kozo.logger.info "the configuration is valid"
      end
    end
  end
end

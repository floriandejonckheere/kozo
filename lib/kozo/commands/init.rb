# frozen_string_literal: true

module Kozo
  module Commands
    class Init < Kozo::Command
      self.description = "Prepare your working directory for other commands"

      def start
        configuration.parse!

        configuration.backend.initialize!

        Kozo.logger.info "Kozo initialized in #{configuration.directory}"
      end
    end
  end
end

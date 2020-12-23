# frozen_string_literal: true

module Kozo
  module Commands
    class Init < Base
      self.description = "Prepare your working directory for other commands"

      def start
        configuration.parse!

        configuration.backend.initialize!

        Kozo.logger.info "Kozo initialized in #{Dir.pwd}"
      end
    end
  end
end

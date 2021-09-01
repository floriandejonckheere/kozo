# frozen_string_literal: true

module Kozo
  module Commands
    class Version < Kozo::Command
      self.description = "Show the current application version"

      def start
        Kozo.logger.info "kozo #{Kozo::VERSION}"
      end
    end
  end
end

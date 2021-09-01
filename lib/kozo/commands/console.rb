# frozen_string_literal: true

module Kozo
  module Commands
    class Console < Kozo::Command
      self.description = "Open an interactive Ruby console"

      def start
        # rubocop:disable Lint/Debugger
        binding.irb
        # rubocop:enable Lint/Debugger
      end
    end
  end
end

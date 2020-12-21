# frozen_string_literal: true

module Kozo
  module Commands
    class Plan < Base
      self.description = "Show execution plan"

      def start
        puts workspace.backend.state
      end
    end
  end
end

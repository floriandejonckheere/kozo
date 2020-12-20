# frozen_string_literal: true

module Kozo
  module Commands
    class Plan < Base
      self.description = "Show execution plan"

      def start
        puts "Collecting #{workspace.configurations.join(', ')}"
      end
    end
  end
end

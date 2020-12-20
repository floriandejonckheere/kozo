# frozen_string_literal: true

module Kozo
  module Commands
    class Plan < Base
      self.description = "Show execution plan"

      def start
        raise NotImplementedError
      end
    end
  end
end

# frozen_string_literal: true

module Kozo
  module Commands
    class Plan < Base
      def self.description
        "Show execution plan"
      end

      def start
        raise NotImplementedError
      end
    end
  end
end

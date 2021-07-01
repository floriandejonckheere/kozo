# frozen_string_literal: true

module Kozo
  module Operations
    class Remove < Operation
      self.symbol = :-

      def apply
        resource.destroy!
      end
    end
  end
end

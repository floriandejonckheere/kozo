# frozen_string_literal: true

module Kozo
  module Operations
    class Add < Operation
      self.symbol = :+

      def apply
        resource.create!
      end
    end
  end
end

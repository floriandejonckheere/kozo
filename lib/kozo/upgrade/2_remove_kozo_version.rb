# frozen_string_literal: true

module Kozo
  class Upgrade
    class RemoveKozoVersion < Kozo::Upgrade
      def upgrade
        state
      end
    end
  end
end

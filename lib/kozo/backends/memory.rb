# frozen_string_literal: true

module Kozo
  module Backends
    class Memory < Kozo::Backend
      def initialize!
        Kozo.logger.debug "Initializing local state in memory"

        # Initialize empty local state
        self.state = State.new
      end

      def data
        Kozo.logger.debug "Reading local state in memory"

        @data
      end

      def data=(value)
        Kozo.logger.debug "Writing local state in memory"

        @data = value
      end
    end
  end
end

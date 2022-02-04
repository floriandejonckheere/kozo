# frozen_string_literal: true

module Kozo
  module Commands
    class State
      class List < State
        self.description = "List resources in the state"

        def initialize(configuration, *_args)
          @configuration = configuration
        end

        def start
          state
            .resources
            .each { |r| Kozo.logger.info r.address }
        end
      end
    end
  end
end

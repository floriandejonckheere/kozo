# frozen_string_literal: true

module Kozo
  module Commands
    class State
      class Show < State
        self.description = "Show a resource in the state"

        attr_reader :address

        def initialize(configuration, *args)
          @configuration = configuration
          @address = args.shift

          raise UsageError, "address not specified" unless address
        end

        def start
          resource = state
            .resources
            .find { |r| r.address == address }

          raise StateError, "no such resource address: #{address}" unless resource

          Kozo.logger.info Operations::Show.new(resource).to_s
        end
      end
    end
  end
end

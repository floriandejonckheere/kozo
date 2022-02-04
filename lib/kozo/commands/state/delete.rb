# frozen_string_literal: true

module Kozo
  module Commands
    class State
      class Delete < State
        self.description = "Delete a resource from the state"

        attr_reader :address

        def initialize(*args, configuration: nil)
          @address = args.shift
          @configuration = configuration

          raise UsageError, "address not specified" unless address
        end

        def start
          resource = state
            .resources
            .find { |r| r.address == address }

          raise StateError, "no such resource address: #{address}" unless resource

          state
            .resources
            .delete_if { |r| r.address == address }

          Kozo.logger.info resource.address

          # Write state
          configuration
            .backend
            .state = state
        end
      end
    end
  end
end

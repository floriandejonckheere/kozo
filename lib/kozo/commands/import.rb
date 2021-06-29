# frozen_string_literal: true

module Kozo
  module Commands
    class Import < Kozo::Command
      self.description = "Import existing resources into the state"

      attr_reader :address, :id

      def initialize(*args)
        address = args.shift

        raise UsageError, "address not specified" unless address

        id = args.shift

        raise UsageError, "id not specified" unless id

        @address = address
        @id = id
      end

      def start
        # Find resource in configuration
        resource = configuration
          .resources
          .find { |r| r.address == address }

        raise StateError, "no such resource address: #{address}" unless resource

        # Set ID and fetch attributes
        resource
          .tap { |r| r.id = id }
          .refresh!

        # Add or replace resource to in-memory state
        state
          .resources << resource

        # Write state
        configuration
          .backend
          .state = state
      end
    end
  end
end

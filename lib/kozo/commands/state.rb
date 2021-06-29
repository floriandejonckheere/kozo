# frozen_string_literal: true

module Kozo
  module Commands
    class State < Kozo::Command
      self.description = "Manage and manipulate state"

      attr_reader :subcommand

      def initialize(*args)
        subcommand = args.shift

        raise UsageError unless subcommand

        klass = "Kozo::Commands::State::#{subcommand.camelize}".safe_constantize

        raise UsageError, "unknown subcommand: state #{subcommand}" unless klass

        @subcommand = klass.new(*args)
      end

      def start
        subcommand
          .start
      end

      class List < State
        self.description = "List resources in the state"

        def initialize(*_args); end

        def start
          state
            .resources
            .each { |r| puts r.address }
        end
      end

      class Show < State
        self.description = "Show a resource in the state"

        attr_reader :address

        def initialize(*args)
          address = args.shift

          raise UsageError, "address not specified" unless address

          @address = address
        end

        def start
          resource = state
            .resources
            .find { |r| r.address == address }

          raise StateError, "no such resource address: #{address}" unless resource

          Kozo.logger.info resource.to_dsl
        end
      end
    end
  end
end

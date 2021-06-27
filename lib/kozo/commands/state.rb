# frozen_string_literal: true

module Kozo
  module Commands
    class State < Kozo::Command
      self.description = "Manage and manipulate state"

      def start
        subcommand = args.shift

        raise UsageError unless subcommand

        klass = "Kozo::Commands::State::#{subcommand.camelize}".safe_constantize

        raise UsageError, "unknown subcommand: state #{subcommand}" unless klass

        klass
          .new(args)
          .start
      end

      class List < State
        self.description = "List resources currently in the state"

        def start
          state
            .resources
            .each { |r| puts r.address }
        end
      end
    end
  end
end

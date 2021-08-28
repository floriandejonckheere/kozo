# frozen_string_literal: true

module Kozo
  module Commands
    class Apply < Plan
      self.description = "Execute a plan"

      attr_reader :parser, :options

      def initialize(*args)
        super()

        @options = {
          yes: false,
        }

        @parser = OptionParser.new do |o|
          o.on("-y", "--yes", "Answer yes to all prompts")
        end.parse!(args, into: options)
      end

      def start
        super

        unless options[:yes]
          print "\nContinue executing these actions (yes/no)? ".bold

          abort("\nApply cancelled") unless gets.chomp == "yes"
        end

        # Apply operations to in-memory state and remote infrastructure
        operations
          .each { |o| o.apply(state) }

        # Write state
        configuration
          .backend
          .state = state
      end
    end
  end
end

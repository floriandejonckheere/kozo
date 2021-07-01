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
          print "\nContinue executing these actions (yes/no)? "

          abort("\nApply cancelled") unless gets.chomp == "yes"
        end

        operations.each(&:apply)
      end
    end
  end
end

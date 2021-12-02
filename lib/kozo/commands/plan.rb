# frozen_string_literal: true

module Kozo
  module Commands
    class Plan < Kozo::Command
      self.description = "Create and show an execution plan"

      attr_reader :operations

      def initialize(*_args)
        @operations = []
      end

      def start
        @operations += configuration.changes.filter_map do |resource|
          if resource.marked_for_creation?
            Operations::Create.new(resource)
          elsif resource.marked_for_deletion?
            Operations::Destroy.new(resource)
          elsif resource.changed?
            Operations::Update.new(resource)
          end
        end

        Kozo.logger.info "Kozo analyzed the state and created the following execution plan. Actions are indicated by the following symbols:"

        [:create, :update, :destroy]
          .map { |c| "Kozo::Operations::#{c.to_s.camelize}".constantize }
          .each { |o| Kozo.logger.info " #{o.display_symbol} #{o.name.demodulize.downcase}" }

        return Kozo.logger.info "\nNo actions have to be performed." if operations.empty?

        Kozo.logger.info "\nKozo will perform the following actions:"

        operations.each { |o| Kozo.logger.info o.to_s }
      end
    end
  end
end

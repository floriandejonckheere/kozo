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
        @operations += configuration.resources.filter_map do |resource|
          state_resource = state.resources.find { |r| r.address == resource.address }

          # Create resource if it does not exist in the state
          next Operations::Add.new(resource) unless state_resource

          # Update resource if its properties have changed
          Operations::Update.new(resource) unless resource.data.except(:id) == state_resource.data.except(:id)
        end

        # Remove state resources without corresponding configuration
        @operations += state
          .resources
          .filter_map { |r| Operations::Remove.new(r) unless configuration.resources.find { |s| s.address == r.address } }

        Kozo.logger.info "Kozo analyzed the state and created the following execution plan. Actions are indicated by the following symbols:"
        Kozo.logger.info " + create"
        Kozo.logger.info " ~ update"
        Kozo.logger.info " - destroy\n"

        Kozo.logger.info "Kozo will perform the following actions:"

        @operations.each { |o| Kozo.logger.info "#{o.symbol} #{o.resource.address}" }
      end
    end
  end
end

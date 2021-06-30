# frozen_string_literal: true

module Kozo
  module Commands
    class Plan < Kozo::Command
      self.description = "Create and show an execution plan"

      attr_reader :add, :remove, :update

      def initialize
        @add = []
        @remove = []
        @update = []
      end

      def start
        configuration.resources.each do |resource|
          state_resource = state.resources.find { |r| r.address == resource.address }

          # Create resource if it does not exist in the state
          next add << resource unless state_resource

          # Update resource if its properties have changed
          update << resource unless resource.data.except(:id) == state_resource.data.except(:id)
        end

        # Remove state resources without corresponding configuration
        state
          .resources
          .reject { |r| configuration.resources.find { |s| s.address == r.address } }
          .each { |r| remove << r }

        add.each { |r| Kozo.logger.info "+ #{r.address}" }
        update.each { |r| Kozo.logger.info "~ #{r.address}" }
        remove.each { |r| Kozo.logger.info "- #{r.address}" }
      end
    end
  end
end

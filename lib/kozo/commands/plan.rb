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
        Refresh.new(configuration: configuration).start

        @operations = changes.filter_map do |resource|
          if !resource.id?
            if resource.id_changed?
              # ID changed to nil (resource should be destroyed)
              Operations::Destroy.new(resource)
            else
              # ID is nil (resource should be created)
              Operations::Create.new(resource)
            end
          elsif resource.changed?
            # Resource should be updated
            Operations::Update.new(resource)
          end
        end

        Kozo.logger.info "Kozo analyzed the state and created the following execution plan. Actions are indicated by the following symbols:"

        [:create, :update, :destroy]
          .map { |c| "Kozo::Operations::#{c.to_s.camelize}".constantize }
          .each { |o| Kozo.logger.info " #{o.display_symbol} #{o.name.demodulize.downcase}" }

        return Kozo.logger.info "\nNo actions have to be performed." if operations.empty?

        Kozo.logger.info "\nKozo will perform the following actions:\n"

        operations.each { |o| Kozo.logger.info o.to_s }
      end
    end
  end
end

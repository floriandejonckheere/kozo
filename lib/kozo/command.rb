# frozen_string_literal: true

module Kozo
  class Command
    class_attribute :description

    attr_reader :args
    attr_accessor :configuration

    def initialize(configuration, *args)
      @configuration = configuration
      @args = args
    end

    def start
      raise NotImplementedError
    end

    def changes
      @changes ||= begin
        # Copy resources in state
        changes = state
          .resources
          .map(&:dup)
          .each(&:clear_changes)
          .each do |resource|
          # Find resource in configuration
          configured = configuration.resources.find { |r| r.address == resource.address }

          if configured
            # Assign updated attributes (mark for update)
            resource.assign_attributes(configured&.updatable_attributes)
          else
            # Set attributes to nil (mark for destruction)
            resource.assign_attributes(resource.attributes.transform_values { nil })
          end
        end

        # Append resources not in state (mark for creation)
        changes += configuration
          .resources
          .reject { |r| state.resources.any? { |res| res.address == r.address } }
          .map { |r| r.class.new(state_name: r.state_name, **r.arguments) }

        changes
      end
    end

    delegate :state, to: :configuration
  end
end

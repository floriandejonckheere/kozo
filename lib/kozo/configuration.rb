# frozen_string_literal: true

module Kozo
  class Configuration
    attr_writer :backend
    attr_accessor :directory, :providers, :resources

    def initialize(directory)
      @directory = directory
      @providers = {}
      @resources = Set.new
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
          configured = resources.find { |r| r.address == resource.address }

          if configured
            # Assign updated attributes (mark for update)
            resource.assign_attributes(configured&.updatable_attributes)
          else
            # Set attributes to nil (mark for destruction)
            resource.assign_attributes(resource.attributes.transform_values { nil })
          end
        end

        # Append resources not in state (mark for creation)
        changes += resources
          .reject { |r| state.resources.any? { |res| res.address == r.address } }
          .map { |r| r.class.new(state_name: r.state_name, **r.arguments) }

        changes
      end
    end

    def backend
      @backend ||= Kozo
        .container
        .resolve("backend.local", self, directory)
    end

    delegate :state, to: :backend

    def to_s
      "directory: #{directory}"
    end
  end
end

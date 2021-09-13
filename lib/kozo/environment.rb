# frozen_string_literal: true

module Kozo
  class Environment
    attr_reader :directory, :configuration

    def initialize(directory, configuration)
      @directory = directory
      @configuration = configuration
    end

    def resources
      @resources ||= begin
        # Copy resources in state
        resources = configuration
          .backend
          .state
          .resources
          .map(&:dup)
          .each(&:changes_applied)
          .map do |resource|
          configured = configuration.resources.find { |r| r.address == resource.address }

          # Assign updated attributes (mark for update)
          resource.assign_attributes(configured&.attributes || resource.attributes.transform_values { nil })

          # Mark for deletion
          resource.mark_for_deletion! unless configured

          resource
        end

        # Append resources not in state
        resources += configuration
          .resources
          .reject { |r| configuration.backend.state.resources.any? { |res| res.address == r.address } }
          .map { |r| r.class.new(r.attributes) }
          .each(&:mark_for_creation!)

        resources
      end
    end
  end
end

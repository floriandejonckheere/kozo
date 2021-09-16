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

    def backend
      @backend ||= Kozo
        .container
        .resolve("backend.local", self, directory)
    end

    def changes
      @changes ||= begin
        # Copy resources in state
        changes = backend
          .state
          .resources
          .map(&:dup)
          .each(&:changes_applied)
          .each do |resource|
          configured = resources.find { |r| r.address == resource.address }

          # Assign updated attributes (mark for update)
          resource.assign_attributes(configured&.attributes&.except(:id) || resource.attributes.transform_values { nil })

          # Mark for deletion
          resource.mark_for_deletion! unless configured
        end

        # Append resources not in state
        changes += resources
          .reject { |r| backend.state.resources.any? { |res| res.address == r.address } }
          .map { |r| r.class.new(r.attributes) }
          .each(&:mark_for_creation!)

        changes
      end
    end

    def to_s
      "directory: #{directory}"
    end
  end
end

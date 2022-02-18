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

    # rubocop:disable Metrics/MethodLength
    def changes
      @changes ||= begin
        # Copy resources in state
        changes = state
          .resources
          .each do |resource|
          # Find resource in configuration
          configured = resources.find { |r| r.address == resource.address }

          if configured
            # Assign updated attributes (mark for update)
            resource.assign_attributes(configured&.readable_attributes&.slice(*configured&.updatable_attribute_names))
          else
            # Set attributes to nil (mark for destruction)
            resource.assign_attributes(resource.readable_attributes.transform_values { nil })
          end
        end

        # Append resources not in state (mark for creation)
        changes += resources
          .reject { |r| state.resources.any? { |res| res.address == r.address } }
          .map { |r| r.class.new(state_name: r.state_name, **r.writeable_attributes) }

        # Create dependency graph
        graph = Graph.new

        # Resolve references
        changes.each do |change|
          change.writeable_attributes.each_value do |attribute|
            attribute.send_wrap do |ref|
              # Skip values that are not references
              next unless ref.respond_to? :resolve

              # Resolve reference
              ref.resolve(changes)

              # Add vertices and edges to dependency graph
              graph[change.address] << graph[ref.address]
            end
          end
        end

        # Order changes according to dependency graph
        changes
          .sort_by! { |r| graph.tsort.index(r.address) }
      end
    end
    # rubocop:enable Metrics/MethodLength

    def backend
      @backend ||= Kozo
        .container
        .resolve("backend.local", self, directory)
    end

    delegate :state, to: :backend

    def to_s
      "directory: #{directory}"
    end

    def inspect
      "#<#{self.class.name} #{self}>"
    end
  end
end

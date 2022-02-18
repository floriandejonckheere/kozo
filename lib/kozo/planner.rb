# frozen_string_literal: true

module Kozo
  class Planner
    attr_accessor :resources_in_state, :resources_in_configuration, :resources
    attr_reader :graph

    def initialize(resources_in_state, resources_in_configuration)
      @resources_in_state = resources_in_state
      @resources_in_configuration = resources_in_configuration

      @resources = resources_in_state.dup
      @graph = Graph.new
    end

    def plan!
      mark_for_update
      mark_for_destroy
      mark_for_create

      build_dependency_graph
      order_resources
    end

    private

    # Assign updated attributes (mark for update)
    def mark_for_update
      resources_with_configuration
        .compact
        .each { |res, config| res.assign_attributes(config&.readable_attributes&.slice(*config&.updatable_attribute_names)) }
    end

    # Set attributes to nil (mark for destruction)
    def mark_for_destroy
      resources_with_configuration
        .select { |_k, v| v.nil? }
        .each { |res, _config| res.assign_attributes(res.readable_attributes.transform_values { nil }) }
    end

    # Append resources not in state (mark for creation)
    def mark_for_create
      self.resources += resources_in_configuration
        .reject { |r| resources_in_state.any? { |res| res.address == r.address } }
        .map { |r| r.class.new(state_name: r.state_name, **r.writeable_attributes) }
    end

    def build_dependency_graph
      resources.each do |resource|
        resource.writeable_attributes.each_value do |attribute|
          attribute.send_wrap do |reference|
            # Skip values that are not references
            next unless reference.respond_to? :resolve

            # Resolve reference
            reference.resolve(resources)

            # Add vertices and edges to dependency graph
            graph[resource.address] << graph[reference.address]
          end
        end
      end
    end

    def order_resources
      resources
        .sort_by! { |r| graph.tsort.index(r.address) }
    end

    def resources_with_configuration
      @resources_with_configuration ||= resources
        .to_h { |resource| [resource, resources_in_configuration.find { |r| r.address == resource.address }] }
    end
  end
end

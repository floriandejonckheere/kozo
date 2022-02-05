# frozen_string_literal: true

module Kozo
  module Operations
    class Update < Operation
      self.symbol = :~
      self.display_symbol = "~".yellow

      def apply(state)
        # Update resource in remote infrastructure
        resource.update!

        # Update resource in local state
        state.resources.delete(resource)
        state.resources << resource
      end

      def to_s
        l = resource.attribute_names.map(&:length).max || 1

        attrs = resource
          .attributes
          .map { |k, v| "  #{resource.changes.key?(k) ? display_symbol : ' '} r.#{k.to_s.ljust(l)} = #{resource.changes.key?(k) ? "#{resource.changes[k].first.as_s.indent(4)[4..]} -> #{v.as_s.indent(4)[4..]}" : v.as_s.indent(4)[4..]}" }
          .join("\n")

        <<~DSL.chomp
          #{"# #{resource.address}:".bold}
          #{display_symbol} resource "#{resource.resource_name}", "#{resource.state_name}" do |r|
          #{attrs}
          end

        DSL
      end
    end
  end
end

# frozen_string_literal: true

module Kozo
  module Operations
    class Create < Operation
      self.symbol = :+
      self.display_symbol = "+".green

      def apply(state)
        # Create resource in remote infrastructure
        resource.create!

        # Add resource to local state
        state.resources << resource
      end

      def to_s
        l = resource.attribute_names.map(&:length).max || 1

        attrs = resource
          .attributes
          .map { |k, v| "  #{resource.changes.key?(k) ? display_symbol : ' '} r.#{k.to_s.ljust(l)} = #{v.blank? && resource.argument_names.exclude?(k) ? '(known after apply)' : (v.as_s.indent(4)[4..]).to_s}" }
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

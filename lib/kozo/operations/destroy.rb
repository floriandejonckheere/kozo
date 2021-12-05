# frozen_string_literal: true

module Kozo
  module Operations
    class Destroy < Operation
      self.symbol = :-
      self.display_symbol = "-".red

      def apply(state)
        # Destroy resource in remote infrastructure
        resource.destroy!

        # Delete resource from local state
        state.resources.delete(resource)
      end

      def to_s
        l = resource.attribute_names.map(&:length).max || 1

        attrs = resource
          .attribute_names
          .map { |k| "  #{display_symbol} r.#{k.to_s.ljust(l)} = #{resource.send(:"#{k}_was").as_s.indent(4)[4..]}" }
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

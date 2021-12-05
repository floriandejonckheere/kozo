# frozen_string_literal: true

module Kozo
  module Operations
    class Show < Operation
      self.symbol = nil
      self.display_symbol = nil

      def apply(state); end

      def to_s
        l = resource.attribute_names.map(&:length).max || 1

        attrs = resource
          .attributes
          .map { |k, v| "  r.#{k.to_s.ljust(l)} = #{v.as_s.indent(4)[4..]}" }
          .join("\n")

        <<~DSL.chomp
          #{"# #{resource.address}:".bold}
          resource "#{resource.resource_name}", "#{resource.state_name}" do |r|
          #{attrs}
          end

        DSL
      end
    end
  end
end

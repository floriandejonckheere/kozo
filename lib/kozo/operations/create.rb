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

      protected

      def attributes_to_s
        l = resource.attribute_names.map(&:length).max || 1

        resource
          .attributes
          .map { |k, v| "#{resource.changes.key?(k) ? display_symbol : ' '}  r.#{k.to_s.ljust(l)} = #{v ? "\"#{v.to_s.chomp.truncate(75)}\"" : '(known after apply)'}" }
          .join("\n  ")
      end
    end
  end
end

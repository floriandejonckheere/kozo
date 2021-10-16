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

      protected

      def attributes_to_s
        l = resource.attribute_names.map(&:length).max || 1

        resource
          .attribute_names
          .map { |k| "#{display_symbol}  r.#{k.to_s.ljust(l)} = \"#{resource.send(:"#{k}_was").to_s.chomp.truncate(75)}\"" }
          .join("\n  ")
      end
    end
  end
end

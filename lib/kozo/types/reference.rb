# frozen_string_literal: true

module Kozo
  module Types
    class Reference < Type
      def self.cast(value)
        return value if value.is_a? Kozo::Reference
        return unless value.is_a? Resource

        # TODO: infer configuration
        Kozo::Reference
          .new(nil, resource: value, resource_class: value.class)
          .send(value.state_name)
      end
    end
  end
end

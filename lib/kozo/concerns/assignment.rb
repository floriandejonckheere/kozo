# frozen_string_literal: true

module Kozo
  module Assignment
    def initialize(attributes = {})
      super()

      assign_attributes(attributes) if attributes
    end

    def assign_attributes(attributes)
      attributes.each do |k, v|
        send(:"#{k}=", v)
      end
    end
  end
end

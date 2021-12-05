# frozen_string_literal: true

module Kozo
  class Operation
    attr_reader :resource

    class_attribute :symbol, :display_symbol

    def initialize(resource)
      @resource = resource
    end

    def apply(_state)
      raise NotImplementedError
    end
  end
end

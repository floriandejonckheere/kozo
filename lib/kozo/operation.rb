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

    def to_s
      "#{display_symbol} #{resource.address}"
    end
  end
end

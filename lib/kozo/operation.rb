# frozen_string_literal: true

module Kozo
  class Operation
    attr_reader :resource

    class_attribute :symbol

    def initialize(resource)
      @resource = resource
    end
  end
end

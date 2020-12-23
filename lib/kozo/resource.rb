# frozen_string_literal: true

module Kozo
  class Resource
    attr_accessor :id, :provider

    class_attribute :name, :provider

    def ==(other)
      id == other.id
    end
  end
end

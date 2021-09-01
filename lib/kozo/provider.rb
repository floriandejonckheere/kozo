# frozen_string_literal: true

module Kozo
  class Provider
    class_attribute :provider_name

    def setup; end

    def ==(other)
      self.class.provider_name == other.class.provider_name
    end
  end
end

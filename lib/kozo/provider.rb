# frozen_string_literal: true

module Kozo
  class Provider
    class_attribute :provider_name

    def initialize!
      raise NotImplementedError
    end
  end
end

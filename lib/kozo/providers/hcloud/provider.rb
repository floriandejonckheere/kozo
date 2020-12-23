# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      class Provider < Kozo::Provider
        attr_accessor :key

        self.name = "hcloud"

        def ==(other)
          key == other.key
        end
      end
    end
  end
end

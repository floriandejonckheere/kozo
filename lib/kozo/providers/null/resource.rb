# frozen_string_literal: true

module Kozo
  module Providers
    module Null
      class Resource < Kozo::Resource
        def self.provider
          Provider
        end
      end
    end
  end
end

# frozen_string_literal: true

module Kozo
  module Providers
    module Null
      class Provider < Kozo::Provider
        self.name = "null"

        def ==(_other)
          true
        end
      end
    end
  end
end
# frozen_string_literal: true

module Kozo
  module Providers
    module Dummy
      class Provider < Kozo::Provider
        self.provider_name = "dummy"
      end
    end
  end
end

# frozen_string_literal: true

module Kozo
  module Providers
    module Null
      class Resource < Kozo::Resource
        self.provider_name = "null"
      end
    end
  end
end

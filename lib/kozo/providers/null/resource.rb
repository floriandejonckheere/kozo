# frozen_string_literal: true

module Kozo
  module Providers
    module Null
      class Resource < Kozo::Resource
        self.provider = "null"
      end
    end
  end
end

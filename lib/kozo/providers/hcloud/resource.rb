# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      class Resource < Kozo::Resource
        self.provider = "hcloud"
      end
    end
  end
end

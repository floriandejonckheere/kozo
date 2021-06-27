# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      class Resource < Kozo::Resource
        self.provider_name = "hcloud"

        attribute :id, :integer
      end
    end
  end
end

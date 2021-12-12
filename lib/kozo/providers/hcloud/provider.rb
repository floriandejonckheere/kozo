# frozen_string_literal: true

require "hcloud"

module Kozo
  module Providers
    module HCloud
      class Provider < Kozo::Provider
        attr_accessor :key

        self.provider_name = "hcloud"

        def setup
          ::HCloud::Client.connection = ::HCloud::Client.new(access_token: key, logger: Kozo.debug_logger)
        end

        def ==(other)
          key == other.key
        end
      end
    end
  end
end

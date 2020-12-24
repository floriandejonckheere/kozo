# frozen_string_literal: true

require "hcloud"

module Kozo
  module Providers
    module HCloud
      class Provider < Kozo::Provider
        attr_accessor :key
        attr_reader :client

        self.provider_name = "hcloud"

        def initialize!
          @client = Hcloud::Client.new(token: key)
        end

        def ==(other)
          key == other.key
        end
      end
    end
  end
end

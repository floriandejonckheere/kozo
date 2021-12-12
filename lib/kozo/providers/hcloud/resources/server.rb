# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class Server < Resource
          self.resource_name = "hcloud_server"

          attribute :name
          attribute :image
          attribute :server_type
          attribute :location
          attribute :datacenter

          attribute :user_data

          attribute :labels, type: :hash

          attribute :ssh_keys, multiple: true, type: :reference

          attribute :locked, argument: false, type: :boolean

          attribute :created, argument: false, type: :time
        end
      end
    end
  end
end

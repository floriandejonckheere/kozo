# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class Server < Resource
          self.resource_name = "hcloud_server"

          argument :name
          argument :image
          argument :server_type
          argument :location
          argument :datacenter

          argument :user_data

          argument :labels, multiple: true

          argument :ssh_keys, multiple: true

          attribute :name
          attribute :image
          attribute :server_type
          attribute :location
          attribute :datacenter

          attribute :user_data

          attribute :locked, type: :boolean

          attribute :labels, multiple: true

          attribute :created, type: :time

          association :ssh_keys, multiple: true
        end
      end
    end
  end
end

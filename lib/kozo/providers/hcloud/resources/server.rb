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
          attribute :labels

          association :firewalls, multiple: true
          association :networks, multiple: true
          association :ssh_keys, multiple: true
          association :volumes, multiple: true

          argument :automount
          argument :start_after_create
        end
      end
    end
  end
end

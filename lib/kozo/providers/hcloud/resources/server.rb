# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class Server < Resource
          self.resource_name = "hcloud_server"

          self.creatable_attribute_names = [:name, :image, :server_type, :location, :datacenter, :user_data, :ssh_keys, :labels]
          self.updatable_attribute_names = [:name, :labels]

          attribute :name
          attribute :image
          attribute :server_type
          attribute :location
          attribute :datacenter

          attribute :user_data

          attribute :labels, type: :hash

          attribute :ssh_keys, multiple: true, type: :reference

          attribute :locked, type: :boolean, readonly: true

          attribute :created, type: :time, readonly: true
        end
      end
    end
  end
end

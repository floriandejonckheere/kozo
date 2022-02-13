# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class Server < Resource
          self.resource_name = "hcloud_server"

          self.creatable_attribute_names = [:name, :image, :server_type, :location, :datacenter, :user_data, :ssh_keys, :labels]
          self.updatable_attribute_names = [:name, :ssh_keys, :labels]

          attribute :name

          attribute :image, wrapped: true
          attribute :server_type, wrapped: true
          attribute :location, wrapped: true
          attribute :datacenter, wrapped: true

          attribute :labels, type: :hash

          readonly

          attribute :locked, type: :boolean

          attribute :created, type: :time

          writeonly

          attribute :user_data

          attribute :ssh_keys, multiple: true, type: :reference
        end
      end
    end
  end
end

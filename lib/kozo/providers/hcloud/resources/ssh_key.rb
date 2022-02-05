# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Resource
          self.resource_name = "hcloud_ssh_key"

          self.creatable_attribute_names = [:name, :public_key, :labels]
          self.updatable_attribute_names = [:name, :labels]

          attribute :name
          attribute :public_key
          attribute :labels, type: :hash

          attribute :created, type: :time, readonly: true
        end
      end
    end
  end
end

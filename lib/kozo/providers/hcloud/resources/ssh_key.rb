# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Resource
          self.resource_name = "hcloud_ssh_key"

          argument :name
          argument :public_key
          argument :labels, multiple: true

          attribute :name
          attribute :public_key

          attribute :fingerprint

          attribute :created
          attribute :labels, multiple: true
        end
      end
    end
  end
end

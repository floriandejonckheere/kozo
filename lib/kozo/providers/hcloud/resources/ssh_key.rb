# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Resource
          self.resource_name = "hcloud_ssh_key"

          attribute :name
          attribute :public_key
          attribute :labels, type: :hash

          attribute :created, type: :time, argument: false
        end
      end
    end
  end
end

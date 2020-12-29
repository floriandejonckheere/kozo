# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Resource
          attr_accessor :name, :public_key

          self.resource_name = "hcloud_ssh_key"

          def data
            {
              name: name,
              public_key: public_key,
            }
          end
        end
      end
    end
  end
end

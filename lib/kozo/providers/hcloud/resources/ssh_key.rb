# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Resource
          self.resource_name = "hcloud_ssh_key"

          attribute :name
          attribute :public_key

          def data
            {
              id: id,
              name: name,
              public_key: public_key,
            }
          end

          def refresh!
            Kozo.logger.info "#{address}: refreshing state"

            ssh_key = provider.client.ssh_keys.find(id)

            self.name = ssh_key.name
            self.public_key = ssh_key.public_key
          end

          def create!
            Kozo.logger.info "#{address}: creating resource"

            ssh_key = provider.client.ssh_keys.create(**data.except(:id))

            self.id = ssh_key.id
            self.name = ssh_key.name
            self.public_key = ssh_key.public_key

            Kozo.logger.info "#{address}: created resource"
          end

          def destroy!; end

          def update!; end
        end
      end
    end
  end
end

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

            attribute_names
              .except("id")
              .each { |attr| send(:"#{attr}=", ssh_key.send(attr)) }

            Kozo.logger.info "#{address}: refreshed state"
          end

          def create!
            Kozo.logger.info "#{address}: creating resource"

            ssh_key = provider.client.ssh_keys.create(**data.except(:id))

            attribute_names
              .each { |attr| send(:"#{attr}=", ssh_key.send(attr)) }

            Kozo.logger.info "#{address}: created resource"
          end

          def destroy!
            Kozo.logger.info "#{address}: destroying resource"

            ssh_key = provider.client.ssh_keys.find(id)

            ssh_key.destroy

            Kozo.logger.info "#{address}: destroyed resource"
          end

          def update!; end
        end
      end
    end
  end
end

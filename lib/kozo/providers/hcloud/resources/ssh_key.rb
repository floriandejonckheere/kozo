# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Resource
          self.resource_name = "hcloud_ssh_key"

          attribute :name
          attribute :public_key

          def refresh!
            Kozo.logger.info "#{address}: refreshing state"

            ssh_key = ::HCloud::SSHKey.find(id)

            attribute_names
              .excluding(:id)
              .each { |attr| send(:"#{attr}=", ssh_key.send(attr)) }

            Kozo.logger.info "#{address}: refreshed state"
          end

          def create!
            Kozo.logger.info "#{address}: creating resource"

            ssh_key = ::HCloud::SSHKey.new(**attributes.except(:id))
            ssh_key.create

            attribute_names
              .each { |attr| send(:"#{attr}=", ssh_key.send(attr)) }

            Kozo.logger.info "#{address}: created resource"
          end

          def destroy!
            Kozo.logger.info "#{address}: destroying resource"

            ssh_key = ::HCloud::SSHKey.find(id)
            ssh_key.delete

            Kozo.logger.info "#{address}: destroyed resource"
          end

          def update!
            Kozo.logger.info "#{address}: updating resource"

            ssh_key = ::HCloud::SSHKey.find(id)
            ssh_key.name = name
            ssh_key.public_key = public_key
            ssh_key.update

            attribute_names
              .excluding(:id)
              .each { |attr| send(:"#{attr}=", ssh_key.send(attr)) }

            Kozo.logger.info "#{address}: updated resource"
          end
        end
      end
    end
  end
end

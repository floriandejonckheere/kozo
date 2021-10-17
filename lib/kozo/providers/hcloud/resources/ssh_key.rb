# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Resource
          self.resource_name = "hcloud_ssh_key"

          attribute :name
          attribute :public_key

          protected

          def refresh
            ssh_key = ::HCloud::SSHKey.find(id)

            attribute_names
              .excluding(:id)
              .each { |attr| send(:"#{attr}=", ssh_key.send(attr)) }
          end

          def create
            ssh_key = ::HCloud::SSHKey.new(**attributes.except(:id))
            ssh_key.create

            attribute_names
              .each { |attr| send(:"#{attr}=", ssh_key.send(attr)) }
          end

          def update
            ssh_key = ::HCloud::SSHKey.find(id)
            ssh_key.name = name
            ssh_key.public_key = public_key
            ssh_key.update

            attribute_names
              .excluding(:id)
              .each { |attr| send(:"#{attr}=", ssh_key.send(attr)) }
          end

          def destroy
            ssh_key = ::HCloud::SSHKey.find(id)
            ssh_key.delete
          end
        end
      end
    end
  end
end

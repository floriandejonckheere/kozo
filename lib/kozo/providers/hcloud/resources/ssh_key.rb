# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Resource
          self.resource_name = "hcloud_ssh_key"

          attribute :name
          attribute :public_key, only: :create
          attribute :labels, type: :hash

<<<<<<< Updated upstream
          attribute :created, type: :time

          def creatable_attributes
            [:name, :public_key, :labels]
          end

          def updatable_attributes
            [:name, :labels]
          end
=======
          attribute :created, type: :time, only: :none
>>>>>>> Stashed changes
        end
      end
    end
  end
end

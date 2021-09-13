# frozen_string_literal: true

module Kozo
  module Providers
    module Dummy
      module Resources
        class Dummy < Resource
          self.resource_name = "dummy"

          attribute :name
          attribute :description

          def data
            {
              id: id,
              name: name,
              description: description,
            }
          end
        end
      end
    end
  end
end

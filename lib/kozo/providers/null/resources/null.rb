# frozen_string_literal: true

module Kozo
  module Providers
    module Null
      module Resources
        class Null < Resource
          self.resource_name = "null"

          attribute :name

          def data
            {
              id: id,
              name: name,
            }
          end
        end
      end
    end
  end
end

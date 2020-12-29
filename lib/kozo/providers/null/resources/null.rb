# frozen_string_literal: true

module Kozo
  module Providers
    module Null
      module Resources
        class Null < Resource
          self.resource_name = "null"

          def data
            {}
          end
        end
      end
    end
  end
end

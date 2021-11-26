# frozen_string_literal: true

module Kozo
  module Providers
    module Dummy
      module Resources
        class Dummy < Resource
          self.resource_name = "dummy"

          argument :name
          argument :description

          attribute :name
          attribute :description
        end
      end
    end
  end
end

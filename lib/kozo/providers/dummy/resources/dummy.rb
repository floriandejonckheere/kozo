# frozen_string_literal: true

module Kozo
  module Providers
    module Dummy
      module Resources
        class Dummy < Resource
          self.resource_name = "dummy"

          self.creatable_attribute_names = [:name, :description]
          self.updatable_attribute_names = [:name, :description]

          attribute :name
          attribute :description

          attribute :location, readonly: true

          attribute :locked, type: :boolean, default: false, readonly: true

          attribute :labels, multiple: true
        end
      end
    end
  end
end

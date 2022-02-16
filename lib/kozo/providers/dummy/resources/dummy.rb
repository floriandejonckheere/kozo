# frozen_string_literal: true

module Kozo
  module Providers
    module Dummy
      module Resources
        class Dummy < Resource
          self.resource_name = "dummy"

          self.creatable_attribute_names = [:name, :references, :labels, :description]
          self.updatable_attribute_names = [:name, :references, :labels, :description]

          attribute :name
          attribute :description

          attribute :references, multiple: true, type: :reference

          attribute :labels, multiple: true

          readonly

          attribute :location

          attribute :locked, type: :boolean, default: false
        end
      end
    end
  end
end

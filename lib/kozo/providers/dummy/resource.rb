# frozen_string_literal: true

module Kozo
  module Providers
    module Dummy
      class Resource < Kozo::Resource
        self.provider_name = "dummy"

        def data
          {}
        end

        def refresh!; end

        def create!; end

        def destroy!; end

        def update!; end
      end
    end
  end
end

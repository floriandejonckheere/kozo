# frozen_string_literal: true

module Kozo
  module Providers
    module Null
      class Resource < Kozo::Resource
        self.provider_name = "null"

        def data
          {}
        end

        def refresh!
          Kozo.logger.info "#{address}: refreshing state"
        end
      end
    end
  end
end

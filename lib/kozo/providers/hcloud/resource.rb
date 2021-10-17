# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      class Resource < Kozo::Resource
        self.provider_name = "hcloud"

        attribute :id, :big_integer

        def refresh!
          Kozo.logger.info "#{address}: refreshing state"

          refresh

          Kozo.logger.info "#{address}: refreshed state"
        end

        def create!
          Kozo.logger.info "#{address}: creating resource"

          create

          Kozo.logger.info "#{address}: created resource"
        end

        def destroy!
          Kozo.logger.info "#{address}: destroying resource"

          destroy

          Kozo.logger.info "#{address}: destroyed resource"
        end

        def update!
          Kozo.logger.info "#{address}: updating resource"

          update

          Kozo.logger.info "#{address}: updated resource"
        end

        protected

        def refresh
          raise NotImplementedError
        end

        def create
          raise NotImplementedError
        end

        def destroy
          raise NotImplementedError
        end

        def update
          raise NotImplementedError
        end
      end
    end
  end
end

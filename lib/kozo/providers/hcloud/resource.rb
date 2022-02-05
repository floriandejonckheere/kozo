# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      class Resource < Kozo::Resource
        self.provider_name = "hcloud"

        attribute :id, type: :integer, readonly: true

        protected

        def refresh
          return unless id

          resource = resource_class.find(id)

          # Set local attributes from remote resource
          attribute_names
            .excluding(:id)
            .each { |attr| send(:"#{attr}=", resource.send(attr)) }
        rescue ::HCloud::Errors::NotFound => e
          raise StateError, "#{address}: #{e.message}"
        end

        def create
          resource = resource_class.new(creatable_attributes)
          resource.create

          # Set local attributes from remote resource
          attribute_names
            .each { |attr| send(:"#{attr}=", resource.send(attr)) }
        rescue ::HCloud::Errors::UniquenessError => e
          raise ResourceError, "#{address}: #{e.message}"
        end

        def update
          resource = resource_class.find(id)

          # Set remote attributes from local resource
          updatable_attribute_names
            .each { |attr| resource.send(:"#{attr}=", send(attr)) }

          resource.update

          attribute_names
            .excluding(:id)
            .each { |attr| send(:"#{attr}=", resource.send(attr)) }
        rescue ::HCloud::Errors::NotFound => e
          raise StateError, "#{address}: #{e.message}"
        rescue ::HCloud::Errors::UniquenessError => e
          raise ResourceError, "#{address}: #{e.message}"
        end

        def destroy
          resource = resource_class.find(id_was)
          resource.delete
        rescue ::HCloud::Errors::NotFound => e
          raise StateError, "#{address}: #{e.message}"
        end

        private

        def resource_class
          "HCloud::#{self.class.name.demodulize}".constantize
        end
      end
    end
  end
end

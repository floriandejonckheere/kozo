# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      class Resource < Kozo::Resource
        self.provider_name = "hcloud"

        attribute :id, type: :integer, readonly: true

        protected

        def refresh
          raise NotPersisted unless id

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
          byebug

          # Set local attributes from remote resource
          attribute_types.map do |attr, options|
            value = resource.send(attr)
            value = value&.send_wrap(:name) if options[:unwrap]
            value = value&.send_wrap { |v| Reference.new(v) } if options[:reference]

            send(:"#{attr}=", value)
          end

          byebug

          # attribute_names
          #   .each { |attr| send(:"#{attr}=", resource.send(attr)) }
        rescue ::HCloud::Errors::UniquenessError => e
          raise ResourceError, "#{address}: #{e.message}"
        end

        def update
          raise NotPersisted unless id

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
          # Use rid, because id will have been blanked
          raise NotPersisted unless rid

          resource = resource_class.find(rid)
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

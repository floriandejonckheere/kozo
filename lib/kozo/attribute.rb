# frozen_string_literal: true

require "active_model"

module Kozo
  module Attribute
    extend ActiveSupport::Concern

    include ActiveModel::Dirty

    included do
      def save
        changes_applied
      end

      def reload!
        clear_changes_information
      end

      def rollback!
        restore_attributes
      end
    end

    class_methods do
      def attribute(name)
        define_attribute_methods :"#{name}"

        instance_variable_set(:"@#{name}", nil)

        define_method(:"#{name}") do
          instance_variable_get(:"@#{name}")
        end

        define_method(:"#{name}=") do |value|
          send(:"#{name}_will_change!") unless value == instance_variable_get(:"@#{name}")

          instance_variable_set(:"@#{name}", value)
        end

        define_method(:"#{name}?") do
          instance_variable_get(:"@#{name}").present?
        end
      end
    end
  end
end

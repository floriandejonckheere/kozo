# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
module Kozo
  module Attributes
    extend ActiveSupport::Concern

    included do
      class_attribute :attribute_types, default: {}

      def read_attribute(name)
        value = instance_variable_get(:"@#{name}")

        return value unless value.nil?

        # Set default
        instance_variable_set(:"@#{name}", (attribute_types[name][:default].dup || (attribute_types[name][:multiple] ? [] : nil)))
      end

      def write_attribute(name, value)
        try(:track_change!, name, value)

        value = if attribute_types[name][:multiple]
                  Array(value).map { |v| attribute_types[name][:type].cast(v) }
                else
                  attribute_types[name][:type].cast(value)
                end

        instance_variable_set(:"@#{name}", value)
      end

      def attributes
        attribute_names
          .to_h { |name| [name, read_attribute(name)] }
      end

      def arguments
        argument_names
          .to_h { |name| [name, read_attribute(name)] }
      end

      def creatable_attributes
        attributes
          .slice(*creatable_attribute_names)
      end

      def updatable_attributes
        attributes
          .slice(*updatable_attribute_names)
      end

      delegate :attribute_names, to: :class
      delegate :argument_names, to: :class
    end

    class_methods do
      def inherited(sub_class)
        super

        sub_class.attribute_types = attribute_types.clone
      end

      def attribute(name, **options)
        name = name.to_sym
        type = Type.lookup(options.fetch(:type, :string))

        try(:track, name)

        options = attribute_types[name] = {
          multiple: !!options[:multiple],
          readonly: !!options.fetch(:readonly, false),
          type: type,
          default: options[:default],
        }

        # Define getter
        unless method_defined? name
          define_method(name) { read_attribute(name) }
          define_method(:"#{name}?") { !!read_attribute(name) }
        end

        # Set getter visibility to public
        public(name)

        # Define setter
        define_method(:"#{name}=") { |value| write_attribute(name, value) } unless method_defined? :"#{name}="

        # Set setter visibility to private if it's readonly
        private(:"#{name}=") if options[:readonly]
      end

      def attribute_names
        @attribute_names ||= attribute_types
          .keys
      end

      def argument_names
        @argument_names ||= attribute_types
          .reject { |_k, v| v[:readonly] }
          .keys
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

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
        attribute_types[name] => { multiple:, type:, wrapped: }

        try(:track_change!, name, value)

        # Unwrap value(s) (call #name on receiver)
        value = value.send_wrap { |v| v.try(:name) || v } if wrapped

        # Cast value(s)
        value = value.send_wrap { |v| type.cast(v) }

        # Convert value(s) to array
        value = Array(value) if multiple

        # Set value(s)
        instance_variable_set(:"@#{name}", value)
      end

      def attributes
        attribute_names
          .to_h { |name| [name, read_attribute(name)] }
      end

      def readable_attributes
        readable_attribute_names
          .to_h { |name| [name, read_attribute(name)] }
      end

      def writeable_attributes
        writeable_attribute_names
          .to_h { |name| [name, read_attribute(name)] }
      end

      def creatable_attributes
        creatable_attribute_names
          .to_h { |name| [name, read_attribute(name).send_wrap(:as_h)] }
      end

      def updatable_attributes
        updatable_attribute_names
          .to_h { |name| [name, read_attribute(name).send_wrap(:as_h)] }
      end

      delegate :attribute_names,
               :readable_attribute_names,
               :writeable_attribute_names,
               to: :class
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

        attribute_types[name] = {
          multiple: !!options[:multiple],
          wrapped: !!options.fetch(:wrapped, false),
          type: type,
          default: options[:default],
          read: read?,
          write: write?,
        }

        # Define getter
        unless method_defined? name
          define_method(name) { read_attribute(name) }
          define_method(:"#{name}?") { !!read_attribute(name) }
        end

        # Set getter visibility to private if it's writeonly
        private(name) if writeonly?

        # Define setter
        define_method(:"#{name}=") { |value| write_attribute(name, value) } unless method_defined? :"#{name}="

        # Set setter visibility to private if it's readonly
        private(:"#{name}=") if readonly?
      end

      def attribute_names
        @attribute_names ||= attribute_types
          .keys
      end

      def readable_attribute_names
        attribute_types
          .select { |_k, v| v[:read] }
          .keys
      end

      def writeable_attribute_names
        attribute_types
          .select { |_k, v| v[:write] }
          .keys
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

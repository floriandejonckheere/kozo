# frozen_string_literal: true

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
    end

    # rubocop:disable Metrics/BlockLength
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
          attribute: !!options.fetch(:attribute, true),
          argument: !!options.fetch(:argument, true),
          type: type,
          default: options[:default],
        }

        # Define getter
        unless method_defined? name
          define_method(name) { read_attribute(name) }
          define_method(:"#{name}?") { !!read_attribute(name) }
        end

        # Set visibility to public if it's an attribute
        options[:attribute] ? public(name) : private(name)

        # Define setter
        define_method(:"#{name}=") { |value| write_attribute(name, value) } unless method_defined? :"#{name}="

        # Set visibility to public if it's an argument
        options[:argument] ? public(:"#{name}=") : private(:"#{name}=")
      end

      def attribute_names
        @attribute_names ||= attribute_types
          .select { |_k, v| v[:attribute] }
          .keys
      end

      def argument_names
        @argument_names ||= attribute_types
          .select { |_k, v| v[:argument] }
          .keys
      end
    end
    # rubocop:enable Metrics/BlockLength

    def attributes
      attribute_names
        .map { |name| [name, read_attribute(name)] }
        .to_h
    end

    def arguments
      argument_names
        .map { |name| [name, read_attribute(name)] }
        .to_h
    end

    delegate :attribute_names, to: :class
    delegate :argument_names, to: :class
  end
end

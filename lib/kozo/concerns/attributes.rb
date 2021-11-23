# frozen_string_literal: true

module Kozo
  module Attributes
    extend ActiveSupport::Concern

    included do
      class_attribute :attribute_types, default: {}
      class_attribute :attribute_defaults, default: {}

      def initialize(...)
        @attributes = self.class.attribute_defaults.deep_dup

        super
      end

      def attributes
        attribute_names
          .map { |name| [name, read_attribute(name)] }
          .to_h
      end

      def attribute_names
        @attributes.keys
      end

      private

      def read_attribute(name)
        instance_variable_get(:"@#{name}") || instance_variable_set(:"@#{name}", (attribute_defaults[name].dup || (attribute_types[name][:multiple] ? [] : nil)))
      end

      def write_attribute(name, value)
        try(:track_change!, name, value)

        value = if attribute_types[name][:multiple]
                  value.map { |v| attribute_types[name][:type].cast(v) }
                else
                  attribute_types[name][:type].cast(value)
                end

        instance_variable_set(:"@#{name}", value)
      end
    end

    module ClassMethods
      # rubocop:disable Style/GuardClause
      def attribute(name, **options)
        name = name.to_sym
        type = Type.lookup(options.fetch(:type, :string))

        self.attribute_types = attribute_types.merge(name => {
          multiple: !!options[:multiple],
          type: type,
        })

        attribute_defaults[name] = options[:default]

        # Define public getter (if not defined already), and force public visibility
        unless method_defined? name
          define_method(name) { read_attribute(name) }
          define_method(:"#{name}?") { !!read_attribute(name) }
        end
        public name

        # Define private setter (if not defined already)
        unless method_defined? :"#{name}="
          define_method(:"#{name}=") { |value| write_attribute(name, value) }

          private :"#{name}="
        end
      end
      # rubocop:enable Style/GuardClause

      def attribute_names
        attribute_types.keys
      end
    end
  end
end

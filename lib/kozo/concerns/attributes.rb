# frozen_string_literal: true

module Kozo
  module Attributes
    extend ActiveSupport::Concern

    included do
      class_attribute :attribute_types, :attribute_defaults
      attr_reader :attributes

      self.attribute_types = {}
      self.attribute_defaults = {}

      def read_attribute(name)
        @attributes[name] ||= (attribute_defaults[name].dup || attribute_types[name][:multiple] ? [] : nil)
      end

      def write_attribute(name, value)
        @attributes[name] = if attribute_types[name][:multiple]
                              value.map { |v| attribute_types[name][:type].cast(v) }
                            else
                              attribute_types[name][:type].cast(value)
                            end
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

    def initialize(...)
      @attributes = self.class.attribute_defaults.deep_dup

      super
    end

    def attribute_names
      @attributes.keys
    end
  end
end

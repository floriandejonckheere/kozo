# frozen_string_literal: true

module Kozo
  module Attributes
    extend ActiveSupport::Concern

    included do
      class_attribute :attribute_types, :attribute_defaults
      attr_reader :attributes

      self.attribute_types = {}
      self.attribute_defaults = {}
    end

    module ClassMethods
      def attribute(name, **options)
        name = name.to_sym
        type = options.fetch(:type) { ActiveModel::Type::Value.new }
        type = ActiveModel::Type.lookup(type) if type.is_a?(Symbol)

        self.attribute_types = attribute_types.merge(name => {
          multiple: !!options[:multiple],
          type: type,
        })

        attribute_defaults[name] = options[:default]

        define_method name do
          @attributes[name] ||= (attribute_defaults[name].dup || attribute_types[name][:multiple] ? [] : nil)
        end
        private name

        define_method :"#{name}=" do |value|
          @attributes[name] = attribute_types[name][:type].cast(value)
        end
      end

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

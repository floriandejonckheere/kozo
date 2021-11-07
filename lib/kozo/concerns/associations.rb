# frozen_string_literal: true

module Kozo
  module Associations
    extend ActiveSupport::Concern

    included do
      class_attribute :association_types
      attr_reader :associations

      self.association_types = {}
    end

    module ClassMethods
      def association(name, **options)
        name = name.to_sym
        self.association_types = association_types.merge(name => {
          multiple: !!options[:multiple],
        })

        define_method name do
          @associations[name] ||= (association_types[name][:multiple] ? [] : nil)
        end

        define_method :"#{name}=" do |value|
          @associations[name] = value
        end
      end

      def association_names
        association_types.keys
      end
    end

    def initialize(...)
      @associations = association_types
        .map { |k, _v| [k, (association_types[k][:multiple] ? [] : nil)] }
        .to_h

      super
    end

    def association_names
      @associations.keys
    end
  end
end

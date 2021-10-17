# frozen_string_literal: true

module Kozo
  module Arguments
    extend ActiveSupport::Concern

    included do
      class_attribute :argument_types, :_default_arguments
      attr_reader :arguments

      self.argument_types = {}
      self._default_arguments = {}
    end

    module ClassMethods
      def argument(name, type = ActiveModel::Type::Value.new, **options)
        name = name.to_s
        type = ActiveModel::Type.lookup(type, **options.except(:default)) if type.is_a?(Symbol)

        self.argument_types = argument_types.merge(name => type)
        _default_arguments[name] = options[:default]

        attr_accessor name
      end

      def argument_names
        argument_types.keys
      end
    end

    def initialize(...)
      @arguments = self.class._default_arguments.deep_dup

      super
    end

    def argument_names
      @arguments.keys
    end
  end
end

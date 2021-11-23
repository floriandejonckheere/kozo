# frozen_string_literal: true

module Kozo
  module Arguments
    extend ActiveSupport::Concern

    included do
      class_attribute :argument_types, :argument_defaults

      self.argument_types = {}
      self.argument_defaults = {}

      def read_argument(name)
        instance_variable_get(:"@#{name}") || instance_variable_set(:"@#{name}", (argument_defaults[name].dup || (argument_types[name][:multiple] ? [] : nil)))
      end

      def write_argument(name, value)
        value = if argument_types[name][:multiple]
                  value.map { |v| argument_types[name][:type].cast(v) }
                else
                  argument_types[name][:type].cast(value)
                end

        instance_variable_set(:"@#{name}", value)
      end
    end

    module ClassMethods
      def argument(name, **options)
        name = name.to_sym
        type = Type.lookup(options.fetch(:type, :string))

        self.argument_types = argument_types.merge(name => {
          multiple: !!options[:multiple],
          type: type,
        })

        argument_defaults[name] = options[:default]

        # Define private getter (if not defined already)
        unless method_defined? name
          define_method(name) { read_argument(name) }
          define_method(:"#{name}?") { !!read_argument(name) }

          private name
        end

        # Define setter (if not defined already), and force public visibility
        define_method(:"#{name}=") { |value| write_argument(name, value) } unless method_defined? name
        public :"#{name}="
      end

      def argument_names
        argument_types.keys
      end
    end

    def initialize(...)
      @arguments = self.class.argument_defaults.deep_dup

      super
    end

    def arguments
      argument_names
        .map { |name| [name, read_argument(name)] }
        .to_h
    end

    def argument_names
      @arguments.keys
    end
  end
end

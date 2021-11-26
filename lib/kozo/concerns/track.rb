# frozen_string_literal: true

module Kozo
  module Track
    extend ActiveSupport::Concern

    included do
      class_attribute :trackables, default: Set.new

      attr_reader :changes

      def changed?
        changes.any?
      end

      def clear_changes
        @changes = {}
      end

      def restore_changes
        changes.each { |key, (from, _to)| send(:"#{key}=", from) }

        clear_changes
      end

      def track_change!(name, value)
        changes[name] = [send(name), value]
      end
    end

    class_methods do
      def track(name)
        trackables << name

        define_method(:"#{name}_change") { changes[name] } unless method_defined? :"#{name}_change"
        define_method(:"#{name}_changed?") { !!changes[name] } unless method_defined? :"#{name}_changed?"
        define_method(:"#{name}_was") { changes.dig(name, 0) } unless method_defined? :"#{name}_was"
      end
    end

    def initialize(...)
      @changes = {}

      super
    end
  end
end

# frozen_string_literal: true

module Kozo
  module Track
    extend ActiveSupport::Concern

    included do
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

    def initialize(...)
      @changes = {}

      super
    end
  end
end

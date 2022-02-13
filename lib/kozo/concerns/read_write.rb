# frozen_string_literal: true

module Kozo
  module ReadWrite
    extend ActiveSupport::Concern

    included do
      class_attribute :mode, default: :readwrite
    end

    class_methods do
      def readwrite
        self.mode = :readwrite
      end

      def readwrite?
        mode == :readwrite
      end

      def readonly
        self.mode = :read
      end

      def readonly?
        mode == :read
      end

      def read?
        mode == :read || mode == :readwrite
      end

      def writeonly
        self.mode = :write
      end

      def writeonly?
        mode == :write
      end

      def write?
        mode == :write || mode == :readwrite
      end
    end
  end
end

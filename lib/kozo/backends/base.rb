# frozen_string_literal: true

module Kozo
  module Backends
    class Base
      attr_accessor :directory

      def initialize(directory)
        @directory = directory
      end

      def providers
        state.fetch(:providers)
      end

      def resources
        state.fetch(:resources)
      end

      protected

      def state
        raise NotImplementedError
      end

      def state=(_value)
        raise NotImplementedError
      end
    end
  end
end

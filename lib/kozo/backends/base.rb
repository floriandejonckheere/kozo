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

      ##
      # Create necessary backend files/structures if they do not exist
      #
      def initialize!
        raise NotImplementedError
      end

      ##
      # Read state from backend
      #
      def state
        raise NotImplementedError
      end

      ##
      # Write state to backend
      #
      def state=(_value)
        raise NotImplementedError
      end
    end
  end
end

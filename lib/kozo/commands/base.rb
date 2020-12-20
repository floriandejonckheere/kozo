# frozen_string_literal: true

module Kozo
  module Commands
    class Base
      attr_reader :options

      def initialize(_args, options)
        @options = options
      end

      def self.description
        raise NotImplementedError
      end

      def start
        raise NotImplementedError
      end
    end
  end
end

# frozen_string_literal: true

module Kozo
  module Commands
    class Base
      attr_reader :options

      def initialize(_args, options)
        @options = options
      end

      def start

      end
    end
  end
end

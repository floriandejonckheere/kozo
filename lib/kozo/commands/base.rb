# frozen_string_literal: true

module Kozo
  module Commands
    class Base
      class_attribute :description

      attr_reader :options

      def initialize(_args, options)
        @options = options
      end

      def start
        raise NotImplementedError
      end
    end
  end
end

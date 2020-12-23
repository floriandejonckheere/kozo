# frozen_string_literal: true

module Kozo
  module Commands
    class Base
      class_attribute :description

      def initialize(*_args); end

      def start
        raise NotImplementedError
      end

      protected

      def configuration
        @configuration ||= Configuration.new(Kozo.options.directory)
      end
    end
  end
end

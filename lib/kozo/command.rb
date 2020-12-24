# frozen_string_literal: true

module Kozo
  class Command
    class_attribute :description

    def initialize(*_args); end

    def start
      raise NotImplementedError
    end

    protected

    def configuration
      @configuration ||= Configuration
        .new(Kozo.options.directory)
        .tap(&:parse!)
    end
  end
end

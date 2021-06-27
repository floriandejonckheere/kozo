# frozen_string_literal: true

module Kozo
  class Command
    class_attribute :description

    attr_reader :args

    def initialize(args = nil)
      @args = args
    end

    def start
      raise NotImplementedError
    end

    protected

    def configuration
      @configuration ||= Configuration
        .new(Kozo.options.directory)
        .tap(&:parse!)
    end

    def state
      @state ||= configuration
        .backend
        .state
    end
  end
end

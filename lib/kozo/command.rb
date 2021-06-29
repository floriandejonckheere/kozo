# frozen_string_literal: true

module Kozo
  class Command
    class_attribute :description

    attr_reader :args

    def initialize(args = [])
      @args = args
    end

    def start
      raise NotImplementedError
    end

    protected

    def configuration
      @configuration ||= Kozo
        .container
        .resolve("configuration", Kozo.options.directory)
        .tap(&:parse!)
    end

    def state
      @state ||= configuration
        .backend
        .state
    end
  end
end

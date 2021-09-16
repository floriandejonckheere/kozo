# frozen_string_literal: true

module Kozo
  class Command
    class_attribute :description

    attr_reader :args
    attr_writer :state, :configuration

    def initialize(*args)
      @args = args
    end

    def start
      raise NotImplementedError
    end

    protected

    def configuration
      @configuration ||= Parser
        .new(Kozo.options.directory)
        .call
    end

    def state
      @state ||= configuration
        .backend
        .state
    end
  end
end

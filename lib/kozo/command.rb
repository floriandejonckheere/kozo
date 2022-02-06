# frozen_string_literal: true

module Kozo
  class Command
    class_attribute :description

    attr_reader :args
    attr_accessor :configuration

    def initialize(configuration, *args)
      @configuration = configuration
      @args = args
    end

    def start
      raise NotImplementedError
    end

    delegate :state,
             :changes,
             to: :configuration
  end
end
